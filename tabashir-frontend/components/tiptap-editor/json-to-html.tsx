"use client";

import Link from "@tiptap/extension-link";
import TextAlign from "@tiptap/extension-text-align";
import Typography from "@tiptap/extension-typography";
import { EditorContent, JSONContent, useEditor } from "@tiptap/react";
import StarterKit from "@tiptap/starter-kit";

export function JsonToHtml({ json }: { json: JSONContent }) {
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
    editable: false,
    editorProps: {
      attributes: {
        class:
          "prose prose-sm sm:prose lg:prose-lg xl:prose-xl   dark:prose-invert [&_p]:my-1 [&_p]:text-base [&_h1]:my-2 [&_h2]:my-2 [&_h3]:my-2 [&_ul]:my-[1px] [&_ol]:my-[1px] [&_li]:my-[1px] [&_li]:text-base ",
          
      },
    },

    content: json,
    immediatelyRender: false,
  });

  return <EditorContent editor={editor} />;
}