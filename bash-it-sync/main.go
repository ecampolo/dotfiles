package main

import (
	"github.com/ecampolo/gotfiles/config"
	"github.com/hashicorp/go-getter"
	"io"
	"io/ioutil"
	"log"
	"os"
	"path"
	"path/filepath"
)

const BashIt = "bash-it"

func main() {
	log.Println("opening config.yml file")
	file, err := os.Open("config.yml")
	if err != nil {
		log.Fatal(err)
	}

	// Create a temporary dir for saving all the bash-it files.
	tmpDir := createTmpDir()
	defer os.RemoveAll(tmpDir)

	client := getter.Client{
		Mode: getter.ClientModeDir,
		Src:  "github.com/Bash-it/bash-it",
		Dst:  path.Join(tmpDir, BashIt),
	}

	log.Println("cloning bash-it repository into " + tmpDir)
	err = client.Get()
	if err != nil {
		log.Fatal(err)
	}

	// Create a local bash-it dir with all the files from bash-it repo that exists in our config.yml
	mkdirIfNotExists("aliases")
	mkdirIfNotExists("plugins")
	mkdirIfNotExists("completion")

	cfg, err := config.Load(file)
	if err != nil {
		log.Fatal(err)
	}

	err = cp(cfg.Aliases, tmpDir, "aliases")
	if err != nil {
		log.Fatal(err)
	}

	err = cp(cfg.Plugins, tmpDir, "plugins")
	if err != nil {
		log.Fatal(err)
	}

	err = cp(cfg.Completions, tmpDir, "completion")
	if err != nil {
		log.Fatal(err)
	}

	log.Println("done")
}

func mkdirIfNotExists(dirName string) {
	out := filepath.Join(BashIt, dirName)
	if _, err := os.Stat(out); os.IsNotExist(err) {
		err := os.MkdirAll(out, os.ModePerm)
		if err != nil {
			log.Fatal(err)
		}
	}
}

func cp(source []string, tmpDir string, subDir string) error {
	out := filepath.Join(tmpDir, BashIt, subDir)
	err := filepath.Walk(out, func(path string, info os.FileInfo, err error) error {
		if contains(info.Name(), source) {
			log.Println("copying " + info.Name())
			in, err := os.Open(path)
			if err != nil {
				log.Fatal(err)
			}
			defer in.Close()

			out, err := os.Create(filepath.Join(BashIt, subDir, info.Name()))
			if err != nil {
				log.Fatal(err)
			}
			defer out.Close()

			_, err = io.Copy(out, in)
			if err != nil {
				log.Fatal(err)
			}
		}
		return nil
	})
	return err
}

func contains(s string, source []string) bool {
	for _, v := range source {
		if v == s {
			return true
		}
	}
	return false
}

func createTmpDir() string {
	tmpDir, err := ioutil.TempDir("", "gotfiles")
	if err != nil {
		log.Fatal(err)
	}
	return tmpDir
}
