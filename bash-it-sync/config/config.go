package config

import (
	"fmt"
	"gopkg.in/yaml.v2"
	"io"
)

func Load(reader io.Reader) (*Configuration, error) {
	r := yaml.NewDecoder(reader)
	var cfg = new(Configuration)
	if err := r.Decode(&cfg); err != nil {
		return nil, fmt.Errorf("unable to decode into struct, %v", err)
	}
	return cfg, nil
}

type Configuration struct {
	Plugins     []string `yaml:"plugins,omitempty"`
	Aliases     []string `yaml:"aliases,omitempty"`
	Completions []string `yaml:"completions,omitempty"`
}
