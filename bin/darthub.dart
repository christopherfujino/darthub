import 'dart:io' as io;
import 'package:args/args.dart' as ar;
import 'package:github/github.dart' as gh;
import 'package:dart_hub/darthub.dart' as dh;

Future<void> main(List<String> args) async {
  final ar.ArgParser argParser = ar.ArgParser(allowTrailingOptions: false);
  final ar.ArgResults argResults = parseArguments(args, argParser);

  if (argResults['help'] == true) {
    usage(argParser.usage, 0);
  }

  final String token = io.Platform.environment['DARTHUB_ACCESS_TOKEN'];
  gh.GitHub client = createClient(token);
  final dh.DartHub darthub = dh.DartHub(client);
  await darthub.init();
  await darthub.createRepository(
    name: argResults['name'],
  );
  print('yay!');
}

gh.GitHub createClient(String token) {
  return gh.GitHub(
    auth: gh.Authentication.withToken(token),
  );
}

ar.ArgResults parseArguments(List<String> args, ar.ArgParser argParser) {
  argParser
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show usage.',
    )
    ..addOption(
      'name',
      help: 'The name of the repository (required).',
    )
    ..addOption(
      'description',
      help: 'The description of the repository.',
    );

  final ar.ArgResults results = argParser.parse(args);
  if (results['name'] == null) {
    usage(argParser.usage);
  }
  return results;
}

void usage(String usage, [int exitcode = 1]) {
  print('Usage: darthub [options...]\n');
  print(usage);
  io.exit(exitcode);
}
