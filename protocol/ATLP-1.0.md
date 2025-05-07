# Autonomous Timeline Protocol Specification version 1.0

Author: Neruthes

Status: WIP

Last revision: 2025-05-06


## Introduction

Autonomous Timeline Protocol (ATLP) is a suite of metadata for RSS.
ATLP defines features that compose a set of plain RSS feeds into a SNS-like timeline,
enabling optional interaction features across sites.

ATLP prioritizes static publishing like traditional RSS;
dynamic features such as inbox are optional for site implementations.

The core idea of ATLP is behavior directives.
A behavior directive is a hint for how an action should be done.
For example, a client app may want to fetch the latest post of a particular user (identified by a handle).
It will, like handling multi-stage software building,
follow a chain of directives to obtain site layout,
then user profile page URL for humans,
then user profile data URL for machines,
then main feed RSS URL for machines,
then post item permalink for humans,
then post item object URL for machines.



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



## Types of URLs


### User Profile Page (UPP)
A human-friendly profile page for web browsers.

### User Profile Metadata (UPM)
A machine-friendly profile JSON.

### Post Item Permalink (PIP)
A human-friendly page for a post item.

### Post Item Object (PIO)
A machine-friendly post item data JSON.

### Main Feed (MF)
A machine-friendly feed of posts.

### Shares Feed (SF)
A machine-friendly feed of posts being shared (or known as retweeted/reposted) by the user.
Contains permalinks to other posts. If body text is supplied, treat as quote-retweet comment.

### Likes Feed (LF)
A machine-friendly feed of posts being like by the user.
Only contains permalinks to other posts.

### Comments Feed (CF)
A machine-friendly feed of posts being commented by the user.
Should contain post permalink (to indicate source) and text body (comment content).

### Full Archive
The feeds above are not meant to contain all history.
A full history archive may be available on a site for older posts.
Also, a site may wish to make posts ephemeral for some months only.



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
