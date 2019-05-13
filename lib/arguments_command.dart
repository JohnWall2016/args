import './command_runner.dart';

class ArgumentsCommand extends Command {
  
  final String description;
  final String name;
  final String arguments;

  ArgumentsCommand(this.name, {this.description = '', this.arguments = ''});

  @override
  String get invocation {
    var parents = [name];
    for (var command = parent; command != null; command = command.parent) {
      parents.add(command.name);
    }
    parents.add(runner.executableName);

    var invocation = parents.reversed.join(" ");
    return subcommands.isNotEmpty
        ? "$invocation <subcommand> $arguments"
        : "$invocation $arguments";
  }

  void run() {
    var params = arguments.trim().split(RegExp(r'[ \t]+'));
    var paramsLength = params.length;
    if (paramsLength > 0) {
      if (RegExp(r'^\[.*?\]$').hasMatch(params[paramsLength - 1])) paramsLength -= 1;
    }
    var argsLength = argResults.rest.length;
    if (paramsLength > argsLength) {
      print('Error: Too many arguments: $paramsLength expected, but $argsLength got.\n');
      print(usage);
      return;
    }
    execute(argResults.rest);
  }

  void execute(List<String> arguments) {
    throw UnimplementedError();
  }

}