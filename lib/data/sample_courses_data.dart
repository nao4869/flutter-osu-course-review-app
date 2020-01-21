import 'package:flutter/material.dart';
import 'package:osu_course_review/models/review.dart';

import '../models/course.dart';
import '../models/review.dart';

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
    reviewsContent:
        'Do Repl.it code problems; study the model solutions carefully.',
  ),
  Review(
    id: 'r2',
    courseId: 'c1',
    reviewsContent:
        'Do your best to stay on top of things and get help from TAs/Slack/Piazza.',
  ),
  Review(
    id: 'r3',
    courseId: 'c1',
    reviewsContent:
        'No textbook required, but free online PDF helps a lot when understanding material. Don\'t get behind on early material as is all reused on assignments... especially classes.',
  ),
  Review(
    id: 'r4',
    courseId: 'c2',
    reviewsContent:
        'No textbook required, but free online PDF helps a lot when understanding material. Don\'t get behind on early material as is all reused on assignments... especially classes.',
  ),
  Review(
    id: 'r5',
    courseId: 'c2',
    reviewsContent:
        'No textbook required, but free online PDF helps a lot when understanding material. Don\'t get behind on early material as is all reused on assignments... especially classes.',
  ),
  Review(
    id: 'r6',
    courseId: 'c3',
    reviewsContent:
        'No textbook required, but free online PDF helps a lot when understanding material. Don\'t get behind on early material as is all reused on assignments... especially classes.',
  ),
];
