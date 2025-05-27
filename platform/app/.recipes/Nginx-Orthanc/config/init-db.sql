-- PostgreSQL initialization script for Orthanc
-- This script will be executed when the PostgreSQL container starts

-- Create the orthanc database if it doesn't exist
-- (Usually handled by POSTGRES_DB environment variable)

-- Grant necessary permissions
GRANT ALL PRIVILEGES ON DATABASE orthanc TO postgres;

-- Create extensions that might be useful for Orthanc
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- The Orthanc PostgreSQL plugin will create the necessary tables automatically
-- when it first connects to the database
