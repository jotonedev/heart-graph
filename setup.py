from distutils.core import setup
from Cython.Build import cythonize
import numpy

with open("README.md", 'r') as f:
    long_description = f.read()

with open('requirements.txt') as f:
    requirements = f.read().splitlines()


setup(
    name='heart-graph',
    version='1',
    ext_modules=cythonize("data.pyx", language_level="3"),
    include_dirs=[numpy.get_include()],
    license='MIT License',
    author='John Toniutti',
    author_email='mrvillager.dev@gmail.com',
    description="Plot your heart rate from your Mi Fit data",
    long_description=long_description,
    long_description_content_type='text/markdown',
    requires=requirements,
    zip_safe=False,
)
