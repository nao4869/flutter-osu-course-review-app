import 'package:flutter/material.dart';

import '../models/course.dart';

const SAMPLE_COURSES = const [
  Course(
    id: 'c1',
    courseName: 'CS160',
    courseContent: 'Computer Science Orientation',
    prerequisite: 'None',
    proctoredexams: 'None',
    groupwork: 'None',
    textbook: 'None',
  ),
  Course(
    id: 'c2',
    courseName: 'CS161',
    courseContent: 'Overview of fundamental concepts of computer science. Introduction to problem solving, software engineering, and object-oriented programming. Includes algorithm design and program development. Students write small programs in C++.',
    prerequisite: 'None',
    proctoredexams: 'Yes',
    groupwork: 'None',
    textbook: 'Starting Out with C++: Early Objects (9th edition)',
  ),
  Course(
    id: 'c3',
    courseName: 'CS162',
    courseContent: 'Introduces data structures, algorithms, and requires students to produce weekly labs and larger bi-weekly projects in C++.',
    prerequisite: 'CS161',
    proctoredexams: 'No',
    groupwork: 'One group project halfway through the quarter where a team of about 5 students implements a given program in C++',
    textbook: 'Starting Out with C++: Early Objects (9th edition)',
  ),
  Course(
    id: 'c4',
    courseName: 'CS261',
    courseContent: 'Teaches abstract data types, dynamic arrays, linked lists, trees and graphs, binary search trees, hash tables, storage management, complexity analysis of data structures. Classwork is done in C (not C++).',
    prerequisite: 'CS162 or CS165 and CS225',
    proctoredexams: 'Yes',
    groupwork: 'Weekly worksheets to complete and discuss in a small group. Must submit typed meeting minutes to Piazza each week.',
    textbook: 'C Programming Language (2nd edition)',
  ),
  Course(
    id: 'c5',
    courseName: 'CS271',
    courseContent: 'Introduction to functional organization and operation of digital computers. Coverage of assembly language; addressing, stacks, argument passing, arithmetic operations, decisions, macros, modularization, linkers and debuggers.',
    prerequisite: 'CS161 or CS165',
    proctoredexams: 'Yes',
    groupwork: 'None',
    textbook: 'Assembly Language for x86 Processors (7th edition)',
  ),
  Course(
    id: 'c6',
    courseName: 'CS290',
    courseContent: 'How to design and implement a multi-tier application using web technologies: creation of extensive custom client- and server-side code, consistent with achieving a high-quality software architecture.',
    prerequisite: 'CS162 or CS165',
    proctoredexams: 'Yes',
    groupwork: 'None',
    textbook: 'Eloquent JavaScript, 2nd Ed.: A Modern Introduction to Programming (2nd edition)',
  ),
];