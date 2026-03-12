"use client"

import { useState } from "react";
import { Button } from "@/components/ui/button";

export default function TestSubscriptionPage() {
  const [result, setResult] = useState<any>(null);
  const [loading, setLoading] = useState(false);

  const testSubscriptionAPI = async () => {
    setLoading(true);
    try {
      const response = await fetch('/api/subscription/latest');
      const data = await response.json();
      setResult({ status: response.status, data });
    } catch (error: any) {
      setResult({ error: error.message });
    } finally {
      setLoading(false);
    }
  };

  const testSubscriptionAPIWithoutAuth = async () => {
    setLoading(true);
    try {
      const response = await fetch('/api/subscription/test');
      const data = await response.json();
      setResult({ status: response.status, data });
    } catch (error: any) {
      setResult({ error: error.message });
    } finally {
      setLoading(false);
    }
  };

  const debugDatabase = async () => {
    setLoading(true);
    try {
      const response = await fetch('/api/subscription/debug');
      const data = await response.json();
      setResult({ status: response.status, data });
    } catch (error: any) {
      setResult({ error: error.message });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Test Subscription API</h1>

      <div className="space-y-4">
        <Button
          onClick={testSubscriptionAPI}
          disabled={loading}
          className="mr-4"
        >
          {loading ? 'Testing...' : 'Test with Auth'}
        </Button>

        <Button
          onClick={testSubscriptionAPIWithoutAuth}
          disabled={loading}
          variant="outline"
          className="mr-4"
        >
          {loading ? 'Testing...' : 'Test without Auth'}
        </Button>

        <Button
          onClick={debugDatabase}
          disabled={loading}
          variant="secondary"
        >
          {loading ? 'Debugging...' : 'Debug Database'}
        </Button>
      </div>

      {result && (
        <div className="bg-gray-100 p-4 rounded-lg mt-4">
          <h2 className="font-semibold mb-2">Result:</h2>
          <pre className="text-sm overflow-auto">
            {JSON.stringify(result, null, 2)}
          </pre>
        </div>
      )}
    </div>
  );
}
