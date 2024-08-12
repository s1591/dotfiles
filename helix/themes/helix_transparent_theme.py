#!/bin/env python

import sys
import requests as req
import re

# https://github.com/helix-editor/helix/tree/master/runtime/themes


class ToTransparent:
    def __init__(self, url):
        self.url = url
        self.theme = {}
        self.keys = [
            "ui.background",
            "ui.popup",
            "ui.window",
            "ui.help",
            "ui.menu.selected",
            "ui.menu",
        ]
        self.__get()

    def addKey(self, *keys):
        self.keys.extend(keys)

    def __get(self):
        self.__convertToGithubRaw()
        self.__getThemeName()
        resp = req.get(self.url)
        self.theme["theme"] = resp.text

    def __convertToGithubRaw(self):
        pattern = r"https://github.com/(.+)blob(.+)"
        res = re.search(pattern, self.url)
        if res is None:
            return
        self.url = (
            "https://raw.githubusercontent.com/" + res.group(1) + res.group(2)[1:]
        )

    def __getThemeName(self):
        self.theme["name"] = ""
        for i in self.url[::-1]:
            if i != r"/":
                self.theme["name"] = i + self.theme["name"]
            else:
                break

    def __removeBg(self, stmt) -> str:
        # "ui.help" = { fg = "overlay2", bg = "surface0", ... } -> ui.help = { fg = "overlay2", ... }

        index = 0
        for i in range(len(self.keys)):
            if self.keys[i] in stmt:
                index = i
                break
        else:
            return ""

        key = self.keys[index]
        self.keys.remove(key)

        A = stmt[stmt.index("{") :].strip("{").strip("}")
        val = "{ "
        sep = ""
        for i in A.split(","):
            if "bg" not in i.split("=")[0]:
                val += sep + i.strip()
                sep = ", "
        val += " }"
        return f'"{key}" =  {val}'

    def write(self, fileName=""):
        baseName = ""
        if not fileName:
            for i in self.theme["name"]:
                if i != ".":
                    fileName += i
                else:
                    baseName = fileName
                    fileName += "_transparent."
        with open(fileName, "w") as themeFile:
            themeFile.write(f"# {self.url}")
            themeFile.write("\n\n")
            themeFile.write(f'inherits = "{baseName}"' + "\n\n")
            for i in self.theme["theme"].split("\n"):
                if not len(self.keys):
                    return
                stmt = self.__removeBg(i)
                if stmt:
                    themeFile.write(stmt + "\n")
            if len(self.keys):
                for i in self.keys:
                    themeFile.write(i + " = " + "{}" + "\n")


if __name__ == "__main__":
    url = ""
    if len(sys.argv) == 1:
        url = input("theme url: ")
    else:
        url = sys.argv[1]
    tTheme = ToTransparent(url)
    tTheme.addKey("ui.popup.info")
    tTheme.write()
