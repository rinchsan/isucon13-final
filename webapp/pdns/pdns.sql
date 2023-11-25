DROP INDEX domain_id ON records;
DROP INDEX ordername ON records;
CREATE INDEX idx_records_name_disabled ON records (name, disabled);
