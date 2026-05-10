#include <iostream>
#include <vector>
#include <stack>
#include <string>
#include <cctype>
using namespace std;

bool isOperator(const string& token) {
    return token == "+" || token == "-";
}

int main() {
    string input;
    getline(cin, input);

    vector<string> tokens;

    // cout << input << '\n';
    for (size_t i = 0; i < input.size(); ++i) {

        // Ignore white spaces
        if (isspace(input[i])) continue;
        
        // Number
        if (isdigit(input[i])) {
            string num;

            while (i < input.size() && isdigit(input[i])) {
                num += input[i];
                ++i;
            }
            --i;
    
            if (num == "0") {
                cout << "error: zero" << '\n';
                return 0;               
            }

            if (num.size() > 1 && num[0] == '0') {
                cout << "error: not number" << '\n';
                return 0;
            }
    
            tokens.push_back(num);
        }
        // Operator
        else if (input[i] == '+' || input[i] == '-') {
            tokens.push_back(string(1, input[i]));
        }
        // Wrong expression
        else {
            cout << "error" << '\n';
            return 0;
        }
    }

    if (tokens.empty() || tokens.size() > 10) {
        cout << "error: over 10 tokens" << '\n';
        return 0;
    }

    // Validate infix
    if (tokens.size() % 2 == 0) {
        cout << "error: not fit operator" << '\n';
        return 0;
    }

    for (size_t i = 0; i < tokens.size(); ++i) {
        if (i % 2 == 0) {
            // Even -> number
            if (isOperator(tokens[i])) {
                cout << "error" << '\n';
                return 0;
            }
        } else {
            // Odd -> operator
            if (!isOperator(tokens[i])) {
                cout << "error" << '\n';
                return 0;
            }
        }
    }

    // infix to postfix
    vector<string> postfix;
    stack<string> opStack;

    for (const string& token: tokens) {
        if (!isOperator(token)) {
            postfix.push_back(token);
        }
        else {
            while (!opStack.empty()) {
                postfix.push_back(opStack.top());
                opStack.pop();
            }
            opStack.push(token);
        }
    }

    while (!opStack.empty()) {
        postfix.push_back(opStack.top());
        opStack.pop();
    }

    for (size_t i = 0; i < postfix.size(); ++i) {
        if (i != 0) {
            cout << ' ';
        }
        cout << postfix[i];
    }
    cout << '\n';

    return 0;
}