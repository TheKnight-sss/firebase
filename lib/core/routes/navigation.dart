import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future pushTo(BuildContext context, String route, {Object? extra}) {
  return context.push(route, extra: extra);
}

pushwithReplacement(BuildContext context, String route, {Object? extra}) {
  context.pushReplacement(route, extra: extra);
}

goToBase(BuildContext context, String route, {Object? extra}) {
  context.go(route, extra: extra);
}

pop(BuildContext context) {
  context.pop();
}
