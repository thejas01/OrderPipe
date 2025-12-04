-- Database initialization script for OrderPipe microservices
-- This script creates the main database and user if needed

-- Create additional databases for different services if needed
CREATE DATABASE IF NOT EXISTS orderpipe_orders;
CREATE DATABASE IF NOT EXISTS orderpipe_inventory;
CREATE DATABASE IF NOT EXISTS orderpipe_payments;
CREATE DATABASE IF NOT EXISTS orderpipe_notifications;
CREATE DATABASE IF NOT EXISTS orderpipe_shipping;

-- Grant permissions
GRANT ALL PRIVILEGES ON DATABASE orderpipe TO orderpipe;
GRANT ALL PRIVILEGES ON DATABASE orderpipe_orders TO orderpipe;
GRANT ALL PRIVILEGES ON DATABASE orderpipe_inventory TO orderpipe;
GRANT ALL PRIVILEGES ON DATABASE orderpipe_payments TO orderpipe;
GRANT ALL PRIVILEGES ON DATABASE orderpipe_notifications TO orderpipe;
GRANT ALL PRIVILEGES ON DATABASE orderpipe_shipping TO orderpipe;