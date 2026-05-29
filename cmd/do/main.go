package main

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

func main() {
	if err := run(); err != nil {
		fmt.Fprintln(os.Stderr, "error:", err)
		os.Exit(1)
	}
}

func run() error {
	repoDir, err := findRepoRoot()
	if err != nil {
		return err
	}

	miseBin, err := findMise()
	if err != nil {
		return err
	}

	miseToml := filepath.Join(repoDir, "mise.toml")
	trust := exec.Command(miseBin, "trust", "-y", miseToml)
	trust.Dir = repoDir
	trust.Stdout = os.Stdout
	trust.Stderr = os.Stderr
	_ = trust.Run()

	args := os.Args[1:]
	if len(args) == 0 {
		args = []string{"help"}
	}

	cmdArgs := append([]string{"run"}, args...)
	cmd := exec.Command(miseBin, cmdArgs...)
	cmd.Dir = repoDir
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin
	return cmd.Run()
}

func findRepoRoot() (string, error) {
	dir, err := os.Getwd()
	if err != nil {
		return "", err
	}

	for {
		candidate := filepath.Join(dir, "mise.toml")
		if info, err := os.Stat(candidate); err == nil && !info.IsDir() {
			return dir, nil
		}

		parent := filepath.Dir(dir)
		if parent == dir {
			break
		}
		dir = parent
	}

	return "", errors.New("could not find repo root with mise.toml from current directory")
}

func findMise() (string, error) {
	if path, err := exec.LookPath("mise"); err == nil {
		return path, nil
	}

	home, err := os.UserHomeDir()
	if err != nil {
		return "", err
	}

	fallback := filepath.Join(home, ".local", "bin", "mise")
	if info, err := os.Stat(fallback); err == nil && !info.IsDir() {
		return fallback, nil
	}

	return "", errors.New("mise is not installed or not on PATH")
}
