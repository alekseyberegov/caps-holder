import setuptools

with open("README.md", "r") as fd:
    long_description = fd.read()

setuptools.setup(
    name="caps-holder",
    version="1.0.0",
    author="Aleksey Beregov",
    author_email="alekseyberegov@gmail.com",
    description="CAPS verification tool",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/alekseyberegov/caps-holder",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.7',
)