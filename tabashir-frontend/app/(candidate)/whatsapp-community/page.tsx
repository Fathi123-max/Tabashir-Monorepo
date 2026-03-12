"use client"

import Link from "next/link";
import { useTranslation } from "@/lib/use-translation";
import { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import { CheckCircle, Copy, ExternalLink } from "lucide-react";
import { toast } from "@/hooks/use-toast";

interface Subscription {
  id: string;
  plan: string;
  status: string;
  startDate: string;
  endDate: string;
}

export default function WhatsappCommunityPage() {
  const { t, isRTL } = useTranslation();
  const searchParams = useSearchParams();
  const [subscription, setSubscription] = useState<Subscription | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // You can replace this with your actual WhatsApp group link
  const whatsappGroupLink = "https://whatsapp.com/channel/0029VbAat9u9sBI5JEzjmr01";

  useEffect(() => {
    const paymentCompleted = searchParams.get('payment_completed');
    const serviceId = searchParams.get('service_id');

    console.log('URL Params:', { paymentCompleted, serviceId });

    if (paymentCompleted === 'true' && serviceId === 'linkedin-optimization') {
      console.log('Fetching subscription...');
      fetchSubscription();
    }
  }, [searchParams]);

  const fetchSubscription = async () => {
    setLoading(true);
    setError(null);
    try {
      console.log('Making API call to /api/subscription/latest');
      const response = await fetch('/api/subscription/latest');
      console.log('API Response status:', response.status);

      if (response.ok) {
        const data = await response.json();
        console.log('API Response data:', data);
        setSubscription(data.subscription);
      } else {
        const errorData = await response.json();
        console.error('API Error:', errorData);
        setError(errorData.error || 'Failed to fetch subscription');
      }
    } catch (error) {
      console.error('Error fetching subscription:', error);
      setError('Network error occurred');
    } finally {
      setLoading(false);
    }
  };

  const copySubscriptionId = async () => {
    if (subscription?.id) {
      try {
        await navigator.clipboard.writeText(subscription.id);
        toast({
          title: "Subscription ID copied!",
          description: "You can now share this ID with the admin on WhatsApp.",
        });
      } catch (error) {
        console.error('Failed to copy:', error);
      }
    }
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  // Debug info
  console.log('Current state:', { subscription, loading, error });

  return (
    <div className={`flex items-center justify-center py-8 sm:py-20 lg:py-40 w-full px-4 ${isRTL ? 'text-right' : 'text-left'}`}>
      <div className="bg-white rounded-lg p-6 sm:p-8 max-w-xl w-full pt-8 sm:pt-[60px] shadow-lg">
        <div className="text-center space-y-4 sm:space-y-6">
          {loading && (
            <div className="text-center">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-600 mx-auto mb-4"></div>
              <p className="text-gray-600">Loading subscription details...</p>
            </div>
          )}

          {error && (
            <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
              <p className="text-red-800 text-sm">Error: {error}</p>
              <button
                onClick={fetchSubscription}
                className="mt-2 text-red-600 hover:text-red-700 underline text-sm"
              >
                Try again
              </button>
            </div>
          )}

          {subscription ? (
            <>
              <div className="flex items-center justify-center mb-4">
                <CheckCircle className="h-8 w-8 text-green-600 mr-2" />
                <h1 className="text-xl sm:text-2xl font-semibold text-gray-900 leading-normal">
                  Payment Successful!
                </h1>
              </div>

              <div className="bg-green-50 border border-green-200 rounded-lg p-4 mb-6">
                <h2 className="text-lg font-semibold text-green-800 mb-3">
                  LinkedIn Optimization Subscription
                </h2>

                <div className="space-y-2 text-sm text-green-700">
                  <div className="flex justify-between">
                    <span>Status:</span>
                    <span className="font-medium capitalize">{subscription.status.toLowerCase()}</span>
                  </div>
                  <div className="flex justify-between">
                    <span>Start Date:</span>
                    <span>{formatDate(subscription.startDate)}</span>
                  </div>
                  <div className="flex justify-between">
                    <span>End Date:</span>
                    <span>{formatDate(subscription.endDate)}</span>
                  </div>
                </div>

                <div className="mt-4 p-3 bg-white border border-green-300 rounded-md">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-xs text-gray-600 mb-1">Subscription ID</p>
                      <p className="font-mono text-sm font-medium text-gray-900 break-all">
                        {subscription.id}
                      </p>
                    </div>
                    <button
                      onClick={copySubscriptionId}
                      className="ml-2 p-2 text-green-600 hover:text-green-700 hover:bg-green-100 rounded-md transition-colors"
                      title="Copy Subscription ID"
                    >
                      <Copy className="h-4 w-4" />
                    </button>
                  </div>
                </div>

                <p className="text-xs text-green-600 mt-3">
                  📱 Share this Subscription ID with our admin on WhatsApp to get started with your LinkedIn optimization service.
                </p>
              </div>
            </>
          ) : !loading && !error ? (
            <h1 className="text-xl sm:text-2xl font-semibold text-gray-900 leading-normal">
              {t("latestUpdateFrom")}
            </h1>
          ) : null}

          <p className="text-base sm:text-lg text-gray-700 mb-6 sm:mb-12">
            {subscription
              ? "Join our WhatsApp community to connect with our team and get support for your LinkedIn optimization service."
              : t("joinWhatsappCommunity")
            }
          </p>

          <div className="pt-2 sm:pt-4 mb-8 sm:mb-20">
            <Link
              href={whatsappGroupLink}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center justify-center w-full max-w-sm mx-auto bg-gradient-to-r from-green-700 to-green-800 hover:from-green-800 hover:to-green-900 text-white font-medium py-3 px-4 rounded-md transition-colors text-center"
            >
              {subscription ? "Join WhatsApp Community" : t("letMeJoinCommunity")}
              <ExternalLink className="ml-2 h-4 w-4" />
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
