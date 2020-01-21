import 'package:flutter/material.dart';
import 'package:osu_course_review/models/review.dart';

import '../models/course.dart';

const SAMPLE_COURSES = const [
  Course(
    id: 'c1',
    courseName: 'CS160 - Computer Orientation',
    courseContent: 'Computer Science Orientation',
    prerequisite: 'None',
    proctoredexams: 'None',
    groupwork: 'None',
    textbook: 'None',
    color: Colors.purple,
  ),
  Course(
    id: 'c2',
    courseName: 'CS161 - Intro to computer science1',
    courseContent:
        'Overview of fundamental concepts of computer science. Introduction to problem solving, software engineering, and object-oriented programming. Includes algorithm design and program development. Students write small programs in C++.',
    prerequisite: 'None',
    proctoredexams: 'Yes',
    groupwork: 'None',
    textbook: 'Starting Out with C++: Early Objects (9th edition)',
    color: Colors.red,
  ),
  Course(
    id: 'c3',
    courseName: 'CS162 - Intro to computer science2',
    courseContent:
        'Introduces data structures, algorithms, and requires students to produce weekly labs and larger bi-weekly projects in C++.',
    prerequisite: 'CS161',
    proctoredexams: 'No',
    groupwork:
        'One group project halfway through the quarter where a team of about 5 students implements a given program in C++',
    textbook: 'Starting Out with C++: Early Objects (9th edition)',
    color: Colors.orange,
  ),
  Course(
    id: 'c4',
    courseName: 'CS261 - Data Structures',
    courseContent:
        'Teaches abstract data types, dynamic arrays, linked lists, trees and graphs, binary search trees, hash tables, storage management, complexity analysis of data structures. Classwork is done in C (not C++).',
    prerequisite: 'CS162 or CS165 and CS225',
    proctoredexams: 'Yes',
    groupwork:
        'Weekly worksheets to complete and discuss in a small group. Must submit typed meeting minutes to Piazza each week.',
    textbook: 'C Programming Language (2nd edition)',
    color: Colors.amber,
  ),
  Course(
    id: 'c5',
    courseName: 'CS271 - Assembly Language',
    courseContent:
        'Introduction to functional organization and operation of digital computers. Coverage of assembly language; addressing, stacks, argument passing, arithmetic operations, decisions, macros, modularization, linkers and debuggers.',
    prerequisite: 'CS161 or CS165',
    proctoredexams: 'Yes',
    groupwork: 'None',
    textbook: 'Assembly Language for x86 Processors (7th edition)',
    color: Colors.blue,
  ),
  Course(
    id: 'c6',
    courseName: 'CS290 - Web development',
    courseContent:
        'How to design and implement a multi-tier application using web technologies: creation of extensive custom client- and server-side code, consistent with achieving a high-quality software architecture.',
    prerequisite: 'CS162 or CS165',
    proctoredexams: 'Yes',
    groupwork: 'None',
    textbook:
        'Eloquent JavaScript, 2nd Ed.: A Modern Introduction to Programming (2nd edition)',
    color: Colors.green,
  ),
];

const SAMPLE_REVIEWS = const [
  Review(
    id: 'r1',
    courseId: 'c1',
    reviewsContent: 'Do Repl.it code problems; study the model solutions carefully; try reading all the optional chapters; pay attention to what is covered on Canvas; do not use concepts/tools not covered yet; find a way to organize the material to keep track of what has been covered; revisit each week at least 2-3 times as you progress through the course; start coding week 9 and week 10 projects early; participate in online discussions — ask & answer; explain concepts to your classmates — helps you solidify; use pythontutor; get in the habit of drawing diagrams and variable states; get in the habit of tracing the code; the learning materials are thoroughly thought-through and have solid underlying logic.',
  ),
  Review(
    id: 'r2',
    courseId: 'c1',
    reviewsContent: 'Do your best to stay on top of things and get help from TAs/Slack/Piazza. There\'s no book and no proctored exams in this python redesign, so the external annoyances are minimal. I took it knowing very little python or programming, and found it to be really quite easy. I found the optional text (which can be downloaded as free PDF or purchased inexpensively as a paperback) to be a wonderful extension and secondary resource. Weekly assignments are short (too short, I would say), and quizzes were open-internet and allowed for a retake. I took the quizzes first and used them to help guide what I looked at as I reviewed the weekly lessons on Canvas. Instructor clearly wants everyone to have reasonable shot at 100% on quizzes, based on this setup. Quiz items are randomized from a larger problem set, and the quiz answer options are randomized as well, so you do have to focus on actually learning the ideas. The instructor introduces git on week one, and assignments are submitted through GitHub. However, the true power of git becomes apparent during weeks 8, 9, and 10, when the projects become long enough to warrant branching and merging. Try to remember that git is your friend when you get there. You can do some early studying via Udemy or other Python resources if you like, but it is not at all required. People who come in knowing Python are actually at a sort of disadvantage: we are forbidden from using non-covered topics and tools, and some Piazza/Slack convos were complaints about Why can\'t I use function.method()?? Do your best to stick to the script, because we are meant to learn the actual logical execution.',
  ),
  Review(
    id: 'r3',
    courseId: 'c1',
    reviewsContent: 'No textbook required, but free online PDF helps a lot when understanding material. Don\'t get behind on early material as is all reused on assignments... especially classes.',
  ),
  Review(
    id: 'r4',
    courseId: 'c2',
    reviewsContent: 'Take a Udemy/Coursera class on Python beforehand. Doing so will morph this class into a cakewalk. I watched people with no prior programming experience wade into this class and have a ton of difficulty. I have no prior professional programming experience but took the Python Masterclass on Udemy over the summer before starting this class and the hardest I had to work was probably on the two projects at the end, both of which took me about 4-8 hours total time each. The time was simply due to how large the projects are compared to previous assignments and subsequent debugging and documenting you will have to do.',
  ),
  Review(
    id: 'r5',
    courseId: 'c2',
    reviewsContent: 'Take an intro to python programing course and you will be fine.',
  ),
  Review(
    id: 'r6',
    courseId: 'c2',
    reviewsContent: 'Take an intro to CS course in Python on Coursera or Udemy before this class. No textbook is needed, but I would google what the best beginner Python books are and buy one of those for extra practice/understanding. Stack Overflow has some pretty bad/inefficient code that doesn’t always work. Rely on academic literature online or your personal Python beginner’s book.',
  ),
  Review(
    id: 'r7',
    courseId: 'c3',
    reviewsContent: 'Start projects early. Stay on top of concepts. ',
  ),
  Review(
    id: 'r8',
    courseId: 'c3',
    reviewsContent: 'Practice as much hand-tracing of code as you can, especially for the midterm and final exam. The book is adequate at explaining concepts, but the video lectures were not very helpful. Do the end of chapter reviews, and code and compile examples from the book if you\'re having a tough time with a topic. Reach out for help when you feel you need it, as once you fall behind it's tough to catch back up. Google and YouTube will become your close friends as they have tons of available helpful information. The accelerated Summer schedule made this class feel a lot tougher than the original reviews I\'d read here. ',
  ),
  Review(
    id: 'r9',
    courseId: 'c3',
    reviewsContent: 'Do practice coding problems',
  ),
];
