# Data-Transformation-and-Automation-Using-SQL
### Project Overview

An Accreditation Body recently launched a platform requiring certification bodies to upload all accredited certificates. With approximately 40,000 to 43,000 active certificates at any time, the upload must follow a specific format consisting of three tables i.e. certificate details and main site information, additional sites, and associated standards.

The existing system stores certificate data separately by standard, requiring monthly manual extraction, validation of changes, transformation in Excel, and upload preparation. This process is time-consuming, prone to manual errors, and difficult to scale as certificate volumes grow.

This project delivers an SQL based solution that automatically consolidates, transforms, and structures certificate data into the required format on a live basis. By removing manual Excel processing, the solution reduces operational effort, improves data consistency, enables faster uploads, and ensures that data quality is maintained at the source system rather than during downstream transformations.

### Business Problem

An Accreditation Body introduced a new platform requiring certification bodies to upload all accredited certificate details in a standardized format. The certification body managed approximately 40,000–43,000 active certificates, with certificate information distributed across multiple records based on certification standards.
 
The existing process required monthly extraction of data from Salesforce and the accreditation platform, comparison of changes, and manual transformation of the data before upload. This process was time-consuming, prone to errors, and difficult to scale.

A key challenge was that Salesforce stored certificate information at a standard level, resulting in multiple records for a single certificate, whereas the accreditation platform required a single record per certificate. In addition, the platform required certificate details to be uploaded in English. As some certificates existed in both English and local-language versions for invoicing or regional requirements, the solution needed to identify the correct record while preventing duplicate certificate entries.

The objective was to automate the transformation process, consolidate certificate data into the required structure, ensure accurate language selection, and generate outputs suitable for direct upload to the accreditation platform.

### Tools Used

PostgreSQL

### Techniques Applied

- Joins
- CTEs
- Aggregation
- Data Transformation
- Automation
- Process Optimisation

### Data Structure

### Existing Process

### SQL Architecture

### SQL Code

### Business Impact

The SQL automation solution significantly improved the efficiency, accuracy, and scalability of the certificate reporting process for the Accreditation Body.

- Eliminated the need for monthly manual extraction and Excel-based transformation of approximately 2,000 certificate changes per month.
- Enabled real-time visibility of over 40,000 active certificates, removing reliance on manual refresh cycles and lag times from the point of certificate issuance to visibility on the website
- Improved audit readiness by ensuring the reporting output directly reflects source system data, allowing discrepancies to be traced back to data entry issues.
- Enhanced scalability, with the ability to handle significantly larger data volumes without additional manual effort.
- Created a reusable transformation framework that can be adapted for other accreditation platforms and reporting requirements.
