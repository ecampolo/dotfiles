package config

import (
	"os"
	"reflect"
	"testing"
)

func TestLoad(t *testing.T) {
	f, err := os.Open("testdata/config.yml")
	if err != nil {
		t.Fatalf("file not found %s", err)
	}

	conf, err := Load(f)
	if err != nil {
		t.Fatalf("error loading file: %s", err)
	}

	if got, want := conf.Plugins, []string{"plugin1", "plugin2", "plugin3"}; !reflect.DeepEqual(got, want) {
		t.Errorf("got: %s, want: %s", got, want)
	}

	if got, want := conf.Aliases, []string{"alias1", "alias2", "alias3"}; !reflect.DeepEqual(got, want) {
		t.Errorf("got: %s, want: %s", got, want)
	}

	if got, want := conf.Completions, []string{"completion1", "completion2", "completion3"}; !reflect.DeepEqual(got, want) {
		t.Errorf("got: %s, want: %s", got, want)
	}
}

func TestLoad_Empty(t *testing.T) {
	f, err := os.Open("testdata/config-empty.yml")
	if err != nil {
		t.Fatalf("file not found: %s", err)
	}

	conf, err := Load(f)
	if err != nil {
		t.Fatalf("error loading file %s", err)
	}

	if len(conf.Plugins) != 0 {
		t.Errorf("have len: %v, want: 0", len(conf.Plugins))
	}

	if len(conf.Completions) != 0 {
		t.Errorf("have len: %v, want: 0", len(conf.Completions))
	}

	if len(conf.Aliases) != 0 {
		t.Errorf("have len: %v, want: 0", len(conf.Aliases))
	}
}
