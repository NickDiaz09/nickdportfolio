---
layout: post
courses: { csa: {week: 1} }
codemirror: True
title: Code Runner - Java
description: Build a lesson using Java.  This allows you to create in Jupyter Notebook code cell for development, plus interact elements with the lesson on the Web
permalink: /code/java
author: John Mortensen
---

## Code-Runner Automation

The notebook (ipynb) to web (html) conversion system automatically generates a "code-runner" web experience from code cells.

## Java Code Cells
- **Java**: `// CODE_RUNNER: Substring`




{% capture challenge0 %}
Methods and Control Structures - indexOf and substring
{% endcapture %}

{% capture code0 %}
// SubstringTester class to test shortenMessage method
public class Main {
    private String shortenMessage(String message, String str) {

        // Candidate
        System.out.println("Original Message: " + message);
        // Removal substring
        System.out.println("Substring to remove: " + str);

        // Find position of str in message
        int position = message.indexOf(str);
        int length = str.length();

        // Not found case
        if (position == -1) {
            System.out.println("No action, substring not found: " + str);
            return message;
        }

        // Found case
        String newFront = message.substring(0,position);	
        String newBack = message.substring(position + length);

        System.out.println("Front: " + newFront);
        System.out.println("Back: " + newBack); 

        return(newFront + newBack);

}

    public void driver() {

        String [][] messageData = {
            {"Hello, OpenCS!", ","}, // Test in the middl
            {"Java code code coding!", "Java"}, // Test at the beginning
            {"Java programming is fun.", "."}, // Test at the end
            {"No substring here", "exception"}, // Test not found
        };
        for (String[] data : messageData) {
            String message = data[0];
            String str = data[1];
            String result = shortenMessage(message, str);
            System.out.println("Shortened Message: " + result);
            System.out.println("-----");
        }   
    }

    public static void main(String[] args) {
        Main tester = new Main();
        tester.driver();
    }
}
{% endcapture %}

{% capture source0 %}
```Java
// CODE_RUNNER: Methods and Control Structures - indexOf and substring 

// SubstringTester class to test shortenMessage method
public class Main {
    private String shortenMessage(String message, String str) {

        // Candidate
        System.out.println("Original Message: " + message);
        // Removal substring
        System.out.println("Substring to remove: " + str);

        // Find position of str in message
        int position = message.indexOf(str);
        int length = str.length();

        // Not found case
        if (position == -1) {
            System.out.println("No action, substring not found: " + str);
            return message;
        }

        // Found case
        String newFront = message.substring(0,position);	
        String newBack = message.substring(position + length);

        System.out.println("Front: " + newFront);
        System.out.println("Back: " + newBack); 

        return(newFront + newBack);

}

    public void driver() {

        String [][] messageData = {
            {"Hello, OpenCS!", ","}, // Test in the middl
            {"Java code code coding!", "Java"}, // Test at the beginning
            {"Java programming is fun.", "."}, // Test at the end
            {"No substring here", "exception"}, // Test not found
        };
        for (String[] data : messageData) {
            String message = data[0];
            String str = data[1];
            String result = shortenMessage(message, str);
            System.out.println("Shortened Message: " + result);
            System.out.println("-----");
        }   
    }

    public static void main(String[] args) {
        Main tester = new Main();
        tester.driver();
    }
}
Main.main(null);

```
{% endcapture %}

{% include code-runner.html
   runner_id="code-java-0"
   language="java"
   challenge=challenge0
   code=code0
   source=source0
%}


## Build Process

When you run `make` or the notebook conversion script:

1. The script detects CODE_RUNNER comments in code cells
2. Extracts the challenge text from the comment
3. Generates a unique `runner_id` based on the permalink + index
4. Strips magic commands (`%%js`) and CODE_RUNNER comments from the code
5. **Clears Jupyter outputs** from cells with CODE_RUNNER (since code-runner provides interactive execution)
6. Injects a code-runner block after the code cell in the generated markdown

### Testing Notebooks

- **In Notebook**: Run cells normally, see outputs using **Help-Toggle Developer Tools**
- **On Website**: Viewers can modify, run code, and view outputs localhost and deployed
- **No Duplication**: Code exists is in both places, but only requires development in notebook (IPYNB)

### Migrating Notebooks 

If you have existing IPYNB lessons with code cell that only run in VSCode:

- You will need to enable your repo for Code Runner support
- Add to frontmatter of the page `codemirror: true`
- Add a comment to the top of desired code-runner cell `// CODE_RUNNER: <challenge text>`
- Run make, view, and test on localhost
- Commit the change to production

The system will automatically generate the code-runner blocks in the page that enable interaction on the Web.
