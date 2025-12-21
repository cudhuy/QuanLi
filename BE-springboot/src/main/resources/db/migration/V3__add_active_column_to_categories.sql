-- Add active column to categories table
ALTER TABLE categories ADD COLUMN active BOOLEAN NOT NULL DEFAULT true;

-- Add description column to categories table  
ALTER TABLE categories ADD COLUMN description TEXT;