Docker container to deploy the “DOI Citation Generator” web application, allowing academic citation and BibTeX references from DOI identifiers.

[![Docker](https://img.shields.io/badge/Docker-ready-blue)](https://www.docker.com/)
[![Alpine](https://img.shields.io/badge/Alpine-3.21-blue.svg)](https://alpinelinux.org/)
[![Nginx](https://img.shields.io/badge/Nginx-1.26.3-orange)](https://nginx.org/)


## Website available at

[https://reff-hlvarona.pages.dev](https://reff-hlvarona.pages.dev)

---

**Detailed feature description:**
The application provides a simple, intuitive interface where, after entering a DOI, it fetches metadata from Crossref in real time and generates bibliographic references in multiple styles (APA, MLA, IEEE, Vancouver, AMA, ABNT, Turabian, ISO 690, and more). It also provides the citation formatted as BibTeX for integration with reference managers and maintains a history of all citations created during the session, with options to copy, export, sort, or clear that record.

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Running the Docker Container](#running-the-docker-container)
4. [Using Docker Compose](#using-docker-compose)
5. [Accessing in the Browser](#accessing-in-the-browser)
6. [Environment Variables](#environment-variables)
7. [Supported Citation Styles](#supported-citation-styles)
8. [Application Structure](#application-structure)
9. [Credits](#credits)
10. [License](#license)

---

## Overview

“DOI Citation Generator” is an application that enables:

- Entering a DOI for an article or academic resource.
- Automatically retrieving metadata from Crossref.
- Generating the citation in various standard styles (APA, MLA, IEEE, Vancouver, AMA, etc.).
- Producing a BibTeX entry for reference managers.
- Storing a session history of generated citations with management options.

## Prerequisites

- Docker installed on the host machine.
- Port `8443` available for HTTPS service.

## Running the Docker Container

From your terminal, run:

```bash
docker run -d \
  -p 8443:443 \
  --name test_gencitation \
  -e TIMEZONE=America/Recife \
  -e REDIRECT_TO_HTTPS=yes \
  -e AUTOCERT=yes \
  humbertovarona/gencitation
```

- `-d`: Runs the container in detached mode.
- `-p 8443:443`: Maps local port 8443 to internal HTTPS port 443.
- `--name`: Assigns a name to the container.
- `TIMEZONE`, `REDIRECT_TO_HTTPS`, `AUTOCERT` environment variables configure timezone, HTTP→HTTPS redirection, and TLS certificate acquisition.

## Using Docker Compose

To simplify deployment, create a `docker-compose.yml` with:

```yaml
version: "3"
services:
  gencitation:
    image: humbertovarona/gencitation
    container_name: test_gencitation
    ports:
      - "8443:443"
    environment:
      - TIMEZONE=America/Recife
      - REDIRECT_TO_HTTPS=yes
      - AUTOCERT=yes
    restart: unless-stopped
```

Then run:

```bash
docker-compose up -d
```

This will start the service in the background with HTTPS configured automatically.

## Accessing in the Browser

Open:

```
https://localhost:8443
```

or

```
https://IP:8443
```

With `REDIRECT_TO_HTTPS=yes`, any attempt to use `http://localhost:8443` is automatically redirected to HTTPS.

---

## Environment Variables

| Variable            | Values    | Purpose                                                    |
| ------------------- | --------- | ---------------------------------------------------------- |
| `TIMEZONE`          | IANA zone | Sets the timezone for logs and TLS certificate generation. |
| `REDIRECT_TO_HTTPS` | `yes/no`  | Forces HTTP→HTTPS redirection when `yes`.                  |
| `AUTOCERT`          | `yes/no`  | Enables automatic TLS certificate retrieval.               |

## Supported Citation Styles

The application supports the following citation styles, each designed for specific disciplines:

- **APA (American Psychological Association)**

  - Use: Social and behavioral sciences.
  - Example:

    > Smith, J. A., & Pérez, L. M. (2020). _Article Title_. _Journal Name_, _15_(3), 123–145. [https://doi.org/10.1000/xyz123](https://doi.org/10.1000/xyz123)

- **MLA (Modern Language Association)**

  - Use: Humanities, especially literature and languages.
  - Example:

    > Smith, John A., and Laura M. Pérez. “Article Title.” _Journal Name_, vol. 15, no. 3, 2020, pp. 123–145, [https://doi.org/10.1000/xyz123](https://doi.org/10.1000/xyz123).

- **Chicago (Notes & Bibliography)**

  - Use: History and some humanities.
  - Footnote example:

    > 1. John A. Smith and Laura M. Pérez, “Article Title,” _Journal Name_ 15, no. 3 (2020): 123–45, [https://doi.org/10.1000/xyz123](https://doi.org/10.1000/xyz123).

  - Bibliography example:

    > Smith, John A., and Laura M. Pérez. 2020. “Article Title.” _Journal Name_ 15, no. 3: 123–145. [https://doi.org/10.1000/xyz123](https://doi.org/10.1000/xyz123).

- **Harvard**

  - Use: Various academic fields; author–date system.
  - Example:

    > Smith, J.A. & Pérez, L.M., 2020. Article Title. _Journal Name_, 15(3), pp.123–145. Available at: [https://doi.org/10.1000/xyz123](https://doi.org/10.1000/xyz123).

- **IEEE (Institute of Electrical and Electronics Engineers)**

  - Use: Engineering and computer science.
  - Example:

    > \[1] J. A. Smith and L. M. Pérez, “Article Title,” _Journal Name_, vol. 15, no. 3, pp. 123–145, 2020.

- **Vancouver**

  - Use: Medical and biomedical sciences; numeric system.
  - Example:

    > 1. Smith JA, Pérez LM. Article Title. Journal Name. 2020;15(3):123–145. doi:10.1000/xyz123.

- **AMA (American Medical Association)**

  - Use: Medical publications.
  - Example:

    > Smith JA, Pérez LM. Article Title. _Journal Name_. 2020;15(3):123–145. doi:10.1000/xyz123.

- **ABNT (Associação Brasileira de Normas Técnicas)**

  - Use: Brazil; multiple disciplines.
  - Example:

    > SMITH, J. A.; PÉREZ, L. M. Article Title. _Journal Name_, v. 15, n. 3, p. 123–145, 2020.

- **Turabian**

  - Use: Chicago style variant for students.
  - Example:

    > Smith, John A., and Laura M. Pérez. 2020. “Article Title.” _Journal Name_ 15, no. 3: 123–145.

- **ISO 690**

  - Use: International standard for bibliographic references.
  - Example:

    > SMITH, John A.; PÉREZ, Laura M. Article Title. Journal Name, 2020, vol. 15, no. 3, p. 123–145. DOI: 10.1000/xyz123.

## Application Structure

The user interface guides users through each citation step:

1. **DOI Input Field**
   Paste or type a DOI, with clipboard support.

2. **Citation Style Dropdown**
   Select a style to view a brief description and example.

3. **Generate Citation Button**
   Initiates the fetch and formatting process, showing loading indicators and error alerts.

4. **Formatted Citation Display**
   Shows the full reference in the chosen style, with copy and export options.

5. **BibTeX Output Panel**
   Presents the citation as a BibTeX entry, ready for copying into reference managers.

6. **Citation History**
   Lists all session-generated citations with controls to sort, copy, export, or clear the history.

Each component ensures a smooth user experience without requiring technical expertise.

## Credits

- **Development & Maintenance**: Humberto Varona
- **Contact**: [humbertovarona@gmail.com](mailto:humbertovarona@gmail.com)

## License

This document and the project are released under the **CC0 1.0 Universal** (public domain) license.

