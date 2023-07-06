# impero_task

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

### Configure project
To **run** the project please follow these steps:

Step to generate missing files:
```
 flutter packages pub run build_runner build
```

### Use auto generated navigation system.
To use the default router first import this in import section
```
import 'package:auto_route/auto_route.dart';
```
And then you can use routing functions like
```
context.router.pushNamed(NAME_OF_THE_ROUTE)
```
