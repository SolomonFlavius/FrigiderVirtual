# frigider_virtual

Flutter project.

## The documentation for the project

The documentation for this project is in the docs directory.
Content:

- the database schema .pdf file
- the database schema .diagrams file - open with Diagrams app (<https://diagrams.app/>)
- readme in the firebase directory

## The software development process

User and epic stories at:

- <https://docs.google.com/document/d/13u1mgB9t1DC6ZoFdqNfOWaE1BXCrK4G4hrB_9oHvof4/edit#heading=h.lmiavvd4e0le>
- <https://docs.google.com/spreadsheets/d/1SNSB2vcXfD7BEEPlCvQF38UTedp6iQQGWQ-2WguKsPY/edit#gid=0>

The design for the databse is in the docs directory.

For source control we used github. All the commits, merges and merge conflicts are tracked in the github repo.

We used github issues for bug reports.

We used gradle for the build process on the android side.
Also we used the firebase cli for the deployment process of functions on the google cloud platform.

We did a refactor in this commit <https://github.com/SolomonFlavius/FrigiderVirtual/commit/63803c7ef778e5cf09c810cda2af1b328abd04b1> to align with the dart code standards from here <https://dart.dev/guides/language/effective-dart/style>

We used some design patterns:

- creation patterns: we created a singleton class (NotificationManagement) using dart's factory connstructors.
- structural patterns: we used a facade pattern to hide the interfaces of the notification management for each platform considering we used firebase messaging and the flutter local notification plugin. We also used the adapater pattern to transfer data between our dart code (class objects) and the firebase database collections which were represented as dart maps.
- behavioral patterns: we used the state pattern to manage the state of the app and the app's widgets.

## The source

The source files are in the lib directory.

## Flutter commands

Get the dependencies you need to run your application by running:

```bash
flutter clean
flutter packages get
```

Run the application

```bash
flutter run
```

Create the android apk.

```bash
flutter build apk --debug
flutter build apk --profile
flutter build apk --release
```
