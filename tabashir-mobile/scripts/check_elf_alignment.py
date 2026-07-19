#!/usr/bin/env python3
"""
Check ELF alignment for 16KB page size compliance.
Usage: python3 check_elf_alignment.py <apk_or_aab_path>
"""
import sys
import os
import zipfile
import struct
import subprocess
import tempfile
import shutil

def check_elf_file(filepath):
    """Check alignment of an ELF .so file using readelf."""
    try:
        result = subprocess.run(
            ['readelf', '-l', filepath],
            capture_output=True, text=True, timeout=10
        )
        if result.returncode != 0:
            return False, f"readelf failed: {result.stderr}"

        lines = result.stdout.split('\n')
        for line in lines:
            if 'LOAD' in line:
                parts = line.split()
                if len(parts) >= 6:
                    align_str = parts[-1]
                    try:
                        align = int(align_str)
                        if align < 0x4000:  # 16KB = 16384 = 0x4000
                            return False, f"LOAD segment alignment is 0x{align:x} (needs >= 0x4000)"
                    except ValueError:
                        continue
        return True, "ELF alignment OK (>= 16KB)"
    except FileNotFoundError:
        return False, "readelf not found. Install binutils."
    except Exception as e:
        return False, f"Error: {e}"

def check_apk_or_aab(path):
    """Check all .so files in an APK or AAB."""
    if not os.path.exists(path):
        print(f"Error: {path} not found")
        sys.exit(1)

    tmpdir = tempfile.mkdtemp()
    try:
        with zipfile.ZipFile(path, 'r') as z:
            so_files = [n for n in z.namelist() if n.endswith('.so')]
            if not so_files:
                print("No .so files found.")
                return

            all_ok = True
            for name in so_files:
                z.extract(name, tmpdir)
                extracted = os.path.join(tmpdir, name)
                ok, msg = check_elf_file(extracted)
                status = "PASS" if ok else "FAIL"
                print(f"[{status}] {name}: {msg}")
                if not ok:
                    all_ok = False

            if all_ok:
                print("\nELF Verification Successful: All .so files are 16KB aligned.")
            else:
                print("\nELF Verification Failed: Some .so files are NOT 16KB aligned.")
                sys.exit(1)
    finally:
        shutil.rmtree(tmpdir, ignore_errors=True)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <path-to-apk-or-aab>")
        sys.exit(1)
    check_apk_or_aab(sys.argv[1])
