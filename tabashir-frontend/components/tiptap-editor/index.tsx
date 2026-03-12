/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useEditor, EditorContent } from "@tiptap/react";
import StarterKit from "@tiptap/starter-kit";
import Link from "@tiptap/extension-link";
import TextAlign from "@tiptap/extension-text-align";
import Typography from "@tiptap/extension-typography";
import { useEffect } from "react";
import { MenuBar } from "./menu-bar";

interface TiptapEditorProps {
  field: any;
}

export default function TiptapEditor({
  field,
}: TiptapEditorProps) {
  const editor = useEditor({
    extensions: [
      StarterKit,
      Link.configure({
        openOnClick: false,
      }),
      TextAlign.configure({
        types: ["heading", "paragraph"],
      }),
      Typography,
    ],
    editorProps: {
      attributes: {
        class:
          "prose prose-sm sm:prose lg:prose-lg xl:prose-xl focus:outline-none min-h-[300px] p-4 max-w-none dark:prose-invert [&_p]:my-1 [&_h1]:my-2 [&_h2]:my-2 [&_h3]:my-2 [&_ul]:my-[1px] [&_ol]:my-[1px] [&_li]:my-[1px",
      },
    },
    onUpdate: ({ editor }) => {
      field.onChange(JSON.stringify(editor.getJSON()));
    },
    content: field.value ? JSON.parse(field.value) : "",
    immediatelyRender: false,
  });

  // Update editor content when form value changes externally
  useEffect(() => {
    if (editor && field.value && editor.getHTML() !== field.value) {
      editor.commands.setContent(JSON.parse(field.value));
    }
  }, [editor, field.value]);

  return (
    <div className="w-full">
      <div className="flex gap-4">
        <div className="flex-1 border rounded-lg overflow-hidden bg-card">
          <MenuBar editor={editor} />
          <EditorContent editor={editor} />
        </div>
        <div className="flex-1 border rounded-lg overflow-hidden bg-card">
          <div className="p-4 border-b bg-muted">
            <h3 className="font-medium">Preview</h3>
          </div>
          <div 
            className="prose prose-sm sm:prose lg:prose-lg xl:prose-xl p-4 max-w-none dark:prose-invert [&_p]:my-1 [&_h1]:my-2 [&_h2]:my-2 [&_h3]:my-2 [&_ul]:my-1 [&_ol]:my-1 [&_li]:my-0.5"
            dangerouslySetInnerHTML={{ __html: editor?.getHTML() || '' }}
          />
        </div>
      </div>
    </div>
  );
}