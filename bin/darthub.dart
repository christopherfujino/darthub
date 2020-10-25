import 'package:github/github.dart' as github;

void main() {
  print('Hello, world!');
  const Map<String, String> repo = <String, String>{
    'name': 'test-repo',
    'description': 'this is a test repo, generated from a script.',
  };
  github.CreateRepository(
    repo['name'],
    autoInit: false,
    description: repo['description'],
    private: false,
  );
}
