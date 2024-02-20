package com.example.myapp;

class Animal {
    public void makeSound() {
        System.out.println("Animal makes a sound");
    }
}

class Dog extends Animal {
    // Correctly overrides the method with the same access modifier
    @Override
    public void makeSound() {
        System.out.println("Dog barks");
    }
}
