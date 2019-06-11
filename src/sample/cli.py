"""cm
Sample Python Project

Usage:
  sample (-h | --help)
  sample (-v | --version)

Options:
  -v --version                  Show version
  -h --help                     Show this screen
"""

import logging
from typing import Optional

import pkg_resources

from docopt import docopt

logging.basicConfig(level=logging.DEBUG)
_LOG = logging.getLogger(__name__)


def main():
    """
    Main function to ingest cli perameters.
    """

    version: Optional[str]
    try:
        version = pkg_resources.get_distribution(__package__).version
    except pkg_resources.DistributionNotFound:
        version = None

    arguments = docopt(__doc__, version=version, options_first=False)
    _LOG.debug("Arguments received: %s", arguments)


if __name__ == "__main__":
    main()
