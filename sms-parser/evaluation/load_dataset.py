"""
Load and pre-filter the raw Bank SMS exports (Bankbox_*.xlsx) for evaluation.

These exports come from a separate SMS-collection tool (see the sibling
'bank-box visualizer' project) with a fixed schema:
S.No, Date & Time, Sender, Bank Code, Bank Name, SMS Body, Read Status, SMS ID

The raw files live outside this repo (they contain real personal data) --
point --input at wherever they actually are on disk.
"""
from pathlib import Path
from typing import Iterable, Sequence

import pandas as pd

DEFAULT_INPUT_FILES = [
    r"D:\Code\#Explore\bank-box visualizer\Bankbox_20260215_002101.xlsx",
    r"D:\Code\#Explore\bank-box visualizer\Bankbox_20260215_182930.xlsx",
    r"D:\Code\#Explore\bank-box visualizer\Bankbox_20260215_224859.xlsx",
]

# Bank codes the user has identified as not real transaction SMS for the
# accounts being tracked (SBI channel codes not tied to an account here).
DEFAULT_EXCLUDED_BANK_CODES = {
    "SBIUPI",
    "SBIBNK",
    "ATMSBI",
    "CBSSBI",
    "SBIINB",
    "SBYONO",
}


def load_raw(paths: Sequence[str] = DEFAULT_INPUT_FILES) -> pd.DataFrame:
    """Concatenate all export files into one dataframe."""
    frames = []
    for p in paths:
        df = pd.read_excel(p)
        df["__source_file"] = Path(p).name
        frames.append(df)
    combined = pd.concat(frames, ignore_index=True)
    combined["SMS Body"] = combined["SMS Body"].astype(str)
    combined["Sender"] = combined["Sender"].astype(str)
    combined["Bank Code"] = combined["Bank Code"].astype(str)
    return combined


def exclude_bank_codes(
    df: pd.DataFrame,
    excluded: Iterable[str] = DEFAULT_EXCLUDED_BANK_CODES,
) -> pd.DataFrame:
    """Drop rows whose (pre-extracted) Bank Code is in the exclusion set."""
    excluded_upper = {c.upper() for c in excluded}
    mask = ~df["Bank Code"].str.upper().isin(excluded_upper)
    return df.loc[mask].reset_index(drop=True)


def load_and_filter(
    paths: Sequence[str] = DEFAULT_INPUT_FILES,
    excluded_bank_codes: Iterable[str] = DEFAULT_EXCLUDED_BANK_CODES,
) -> pd.DataFrame:
    df = load_raw(paths)
    return exclude_bank_codes(df, excluded_bank_codes)
