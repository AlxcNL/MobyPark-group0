```mermaid

sequenceDiagram
    User->>ScrapeLyrics: LyricsURL
    ScrapeLyrics-->>lyricstranslate.com: scrape
    lyricstranslate.com->>ScrapeLyrics: HTML
    ScrapeLyrics->>User: LyricsFile, MetadataFile
```