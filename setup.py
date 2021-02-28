from setuptools import setup, find_packages

setup(
    name='snapshot',
    version='1.1',
    author='Vitali Lukashevich',
    description='log to file script',
    packages=find_packages(),

    entry_points={
        'console_scripts': [
            'snapshot = log.snapshot:output_log_by_timer',
        ],
    },

    install_requires=[
        'psutil',
        'argparse'
    ],
)
