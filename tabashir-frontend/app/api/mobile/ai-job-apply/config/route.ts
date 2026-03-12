import { NextRequest, NextResponse } from 'next/server';
import { getToken } from 'next-auth/jwt';

/// GET /api/mobile/ai-job-apply/config
/// Returns configuration for AI Job Apply feature
/// Includes roles, locations, nationalities, and display settings
export async function GET(request: NextRequest) {
  try {
    // Verify authentication
    const token = await getToken({ req: request, secret: process.env.NEXTAUTH_SECRET });

    if (!token) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // Configuration data
    // In production, this could be fetched from a database
    // or external configuration service
    const config = {
      popularRoles: [
        'Software Engineer',
        'Frontend Developer',
        'Backend Developer',
        'Full Stack Developer',
        'Mobile Developer',
        'Data Scientist',
        'Product Manager',
        'UI/UX Designer',
        'DevOps Engineer',
        'Project Manager',
        'Business Analyst',
        'QA Engineer',
        'Machine Learning Engineer',
        'Cloud Architect',
        'Cybersecurity Specialist',
      ],
      popularLocations: [
        'Dubai',
        'Abu Dhabi',
        'Sharjah',
        'Ajman',
        'Ras Al Khaimah',
        'Umm Al Quwain',
        'Fujairah',
        'Remote',
        'Hybrid',
      ],
      nationalities: [
        'United Arab Emirates',
        'Saudi Arabia',
        'Egypt',
        'India',
        'Pakistan',
        'Philippines',
        'United Kingdom',
        'United States',
        'Canada',
        'Australia',
        'Jordan',
        'Lebanon',
        'Nigeria',
        'Bangladesh',
        'Sri Lanka',
      ],
      maxRolesToShow: 6,
      maxLocationsToShow: 5,
      defaultAiConfidence: 85,
      version: '1.0.0',
      // Configuration expires in 24 hours
      expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString(),
    };

    // Set cache headers (client can cache for 1 hour)
    return NextResponse.json(config, {
      status: 200,
      headers: {
        'Cache-Control': 'public, max-age=3600, s-maxage=3600',
        'Content-Type': 'application/json',
      },
    });
  } catch (error) {
    console.error('Error fetching AI job apply config:', error);

    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
