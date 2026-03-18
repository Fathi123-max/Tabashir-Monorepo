"use client";

import { useState, useEffect } from "react";
import { checkUserHasResume } from "@/actions/resume";

export function useHasResume() {
  const [hasResume, setHasResume] = useState<boolean | null>(null);
  const [loading, setLoading] = useState(true);

  const check = async () => {
    try {
      setLoading(true);
      const result = await checkUserHasResume();
      setHasResume(result.hasResume || false);
    } catch (error) {
      console.error("Error checking resume status:", error);
      setHasResume(false);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    check();
  }, []);

  return { hasResume, loading, refresh: check };
}
