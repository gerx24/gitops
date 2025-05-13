# CRDB Cluster Management

This repository contains a scheduled workflow for managing backups of the `vulcan_core_prod` database and performing PostgreSQL dumps. The process ensures that backups are handled efficiently and stored appropriately.

## Workflow Overview

### Daily Backup Workflow

A GitHub Actions workflow is scheduled to run **every day at 00:00 UTC**. This workflow is defined in the file: [dbprod-backup.yaml](https://github.com/elc-online/crdb-cluster-management/actions/workflows/dbprod-backup.yaml).

#### Workflow Steps:
1. **Backup Creation**:
   - The workflow creates a backup of the `vulcan_core_prod` database.
2. **Storage**:
   - The backup is pushed to the bucket:
     ```
     elco-dbprod-usva-pincer-int-cleanse-locality-crdb/crdb_backups/
     ```

### PostgreSQL Dump CronJob

Following the backup process, a Kubernetes CronJob is configured to run **30 minutes after the backup is pushed**. This CronJob performs a PostgreSQL dump.

#### CronJob Steps:
1. **Dump Creation**:
   - The CronJob generates a `pg_dump.sql` file containing the database dump.
2. **Storage**:
   - The dump file is pushed to the bucket:
     ```
     elco-crdb-to-postgres/pg-dumps/
     ```
   - The filename includes the date to facilitate easy identification and retrieval.

## Schedule Summary

- **Daily Backup**: Runs at 00:00 UTC
- **PostgreSQL Dump CronJob**: Runs 30 minutes after the backup completes

## Prerequisites

- Ensure you have access to the necessary cloud storage buckets.
- Proper permissions must be configured for the GitHub Actions workflow and Kubernetes CronJob.

## Usage

1. **Monitoring Backups**: You can monitor the backup workflow via the GitHub Actions tab in the repository.
2. **Accessing Dumps**: The PostgreSQL dump files can be accessed in the specified storage bucket, organized by date.

## Conclusion

This automated backup process ensures that your database is backed up regularly and that PostgreSQL dumps are readily available for use. For any questions or issues, please open an issue in this repository.

