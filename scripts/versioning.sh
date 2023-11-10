#!/bin/sh

PROJECT=$1
ENV=$2

LAST_TAG=$(git tag -l "*-$PROJECT" | sort -V | tail -1)

IFS='-.' read -r -a tag_components <<< "$LAST_TAG"

MAJOR=${tag_components[0]}
MINOR=${tag_components[1]}
PATCH=${tag_components[2]}

if [ "$ENV" == "test" ]; then
    PATCH=$((PATCH + 1))
    NEW_TAG="$MAJOR.$MINOR.$PATCH-rc-$PROJECT"
    echo $NEW_TAG
elif [ "$ENV" == "dev" ]; then
    NEW_TAG="$MAJOR.$MINOR.$PATCH-$PROJECT"
    echo $NEW_TAG
elif [ "$ENV" == "prod" ]; then
    if [ "$MINOR" -eq 9 ]; then
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
    else
        MINOR=$((MINOR + 1))
        PATCH=0
    fi
    NEW_TAG="$MAJOR.$MINOR.$PATCH-$PROJECT"
    echo $NEW_TAG
fi