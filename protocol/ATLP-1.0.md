# Autonomous Timeline Protocol Specification version 1.0

Author: Neruthes

Status: WIP

Last revision: 2025-05-06


## Introduction

Autonomous Timeline Protocol (ATLP) is a suite of metadata for RSS.
ATLP defines extension features that
composite a set of plain RSS feeds into a SNS-like timeline,
enabling optional interaction features across instances.

ATLP prioritizes static publishing like traditional RSS;
dynamic features such as inbox are optional.



## Terminology

SITE: A deployed online instance that hosts multiple users.

USER: A profile with a set of feeds.

CLIENT: A client app that subscribes to feeds, and optionally, pushes data to own feeds as well as inboxes of other users.

HANDLE: A string like email address format.

USERNAME: The username part of the HANDLE.

HOSTNAME: The hostname part of the HANDLE.

FEED: A traditional RSS XML.

PROFILE: User metadata JSON.



## Discovery

ATLP employs the `.well-known` conventions.
The SITE owner is supposed to put atlp-manifest.json in the directory.

As a matter of fallback, implementations are encouraged to support locating atlp-manifest.json at website root.

Data retrieval of user profile and timeline from a HANDLE consists of several steps where discovery plays a role.

- For each HANDLE, get its hostname and username.
- Fetch the atlp-manifest.json file from hostname over HTTP/HTTPS.
- Get the user profile pattern in it.



## Manifest Format

The atlp-manifest.json file is a JSON dictionary. Data should be available on some paths.

### Variables

May contain the following variables.

- username
- hostname

### atlp.features

Dictionary of flags indicating whether a feature is enabled.

| Key                 | Default              | Other values | Description                           |
| ------------------- | -------------------- | ------------ | ------------------------------------- |
| inbox               | false                | true         | Site allows inbox inputting?          |
| inbox_method        | smtp                 | -            | Site accepts inbox inputting via SMTP |
| inbox_smtp_endpoint | atlpinbox@{hostname} | -            | Deliver inbox items to which endpoint |

### atlp.url_patterns.user_profile_human
User profile URL pattern, for web browsers.

### atlp.url_patterns.user_profile_machine
User profile URL pattern, for client apps.
