"use client";

import { useEditor, EditorContent } from "@tiptap/react";
import StarterKit from "@tiptap/starter-kit";
import Link from "@tiptap/extension-link";
import TextAlign from "@tiptap/extension-text-align";
import Typography from "@tiptap/extension-typography";
import Placeholder from "@tiptap/extension-placeholder";
import { useEffect } from "react";
import { MenuBar } from "./rich-text-editor/menu-bar";

interface RichTextEditorProps {
  value?: string;
  onChange?: (value: string) => void;
  placeholder?: string;
  minHeight?: string;
  className?: string;
}

export default function RichTextEditor({
  value,
  onChange,
  placeholder = "Start writing...",
  minHeight = "200px",
  className,
}: RichTextEditorProps) {
  const editor = useEditor({
    extensions: [
      StarterKit.configure({
        heading: {
          levels: [1, 2, 3],
        },
      }),
      Link.configure({
        openOnClick: false,
        HTMLAttributes: {
          class: "text-blue-500 hover:text-blue-700 underline",
        },
      }),
      TextAlign.configure({
        types: ["heading", "paragraph"],
      }),
      Typography,
      Placeholder.configure({
        placeholder,
      }),
    ],
    editorProps: {
      attributes: {
        class: `prose prose-sm sm:prose lg:prose-lg xl:prose-xl focus:outline-none p-4 max-w-none spacy-y-2 ${className}`,
      },
    },
    onUpdate: ({ editor }) => {
      const json = editor.getJSON();
      onChange?.(JSON.stringify(json));
    },
    content: value ? JSON.parse(value) : "",
  });

  // Update editor content when value changes externally
  useEffect(() => {
    if (!editor || !value) return;
    
    try {
      const parsedContent = JSON.parse(value);
      const currentContent = editor.getJSON();
      
      // Only update if content is different
      if (JSON.stringify(currentContent) !== JSON.stringify(parsedContent)) {
        editor.commands.setContent(parsedContent);
      }
    } catch (error) {
      console.error("Error parsing editor content:", error);
    }
  }, [editor, value]);

  return (
    <div className="w-full">
      <div 
        className="border rounded-lg overflow-hidden bg-card" 
        style={{ minHeight }}
      >
        <MenuBar editor={editor} />
        <EditorContent 
          editor={editor} 
          className="prose-sm sm:prose lg:prose-lg xl:prose-xl max-w-none dark:prose-invert w-full"
        />
      </div>
    </div>
  );
} 