<!-- Author: J.A.Boogaard@hr.nl -->

# Class Diagrams

## Classes

### Translation
<p>
Een vertaling (Translation) bevat een verwijzing naar de Lyric (Song) en de gebruiker (User) die de vertaling heeft toegevoegd. Tijdens het toevoegen van de vertaling moet de gebruiker aangeven of hij de vertaling zelf heeft geschreven (Authorship). Er kunnen door de gebruiker één of meerdere tags (commented, poetic, singable, rhyming, metered, equithythmic) worden geselecteerd om aan de vertaling te worden toegevoegd. Na het publiceren kunnnen ook andere gebruikers een Comment toevoegen. Zie het State Digram voor de verschillende toestanden waarin een vertaling zich kan bevinden. 
</p>

```mermaid
classDiagram
    class Translation
    Translation : +Song Lyric
    Translation : +Language Language
    Translation : +BigString Songtext
    Translation : +Set(String) Tags
    Translation : +Set(Comments) AddedComments
    Translation : +User SubmittedBy
    Translation : +Boolean Authorship
    Translation : +String State
    Translation : -Date SubmissionDate

    %%  Red
    style Translation fill:#f00
```

### Song

<p>
Tijdens het publiceren kan de gebruiker een Comment toevoegen. Na het publiceren kunnnen ook andere gebruikers een Comment toevoegen. Alle geregristreerde gebruikers mogen een vertaling (Translation) aan een Song toevoegen. Tijdens het publiceren wordt er automatisch metadata toegevoegd die niet door een gebruiker kan worden aangepast.
</p>

```mermaid

classDiagram
    class Song
    Song : +String SongTitle
    Song : +BigString Songtext
    Song : +Set(Language) Languages
    Song : +String ArtistName
    Song : +String Album
    Song : +String Video
    Song : +User SubmittedBy
    Song : +Set(Artist) AlsoPerformedBy
    Song : +Set(Artist) FeaturingArtist
    Song : -Date SubmissionDate
    Song : -Set(String) Writers

    %% Dark Blue
    style Song fill:#00f
```

### Artist
<p>
bij een artiest (Artist) wordt metadata opgeslagen zoals Country, Genre en links naar Websites. De set van talen (Languages) bevat de talen van de artiest gekoppelde Lyrics.
</p>

```mermaid

classDiagram
    class Artist
    Artist : +String Country
    Artist : +Set(Languages) Languages
    Artist : +String Genre
    Artist : +String OfficialSite
    Artist : +String Wiki
    Artist : +Set(Song) Lyrics

    %% Orange
    style Artist fill:orange   
```

## Relationships

### Language

<p>
Bij deze website gaat het om vertalingen (Translation) maar Song is de verbindende Class. Een Song mag bestaan zonder Translation. Een User mag maar 1 vertaling in 1 taal (Language) per Song maken. Omdat meerder gebruikers vertalingen mogen toevoegen kan een Song meerdere vertalingen in dezelfde taal hebben (zie bijvoorbeeld <a href="https://lyricstranslate.com/en/tali-fighter-lyrics">Tali - Fighter</a>).
</p>

```mermaid

classDiagram
    Song "1" -- "*" Translation
    Song "1..*" -- "1..*" Language : written in
    Translation "1..*" -- "1..*" Language

    %% Colors
    %%  Red
    style Translation fill:#f00
    %% Dark Blue
    style Song fill:#00f
    %% Purple
    style Language fill:#f0f
```

### User

<p>
Een Song kan maar door 1 User gepubliceerd worden. Voordat een User kan publiceren moet deze eerst worden geregistreerd. Een User kan dus geen of meerdere Songs, vertalingen en commentaren hebben gepubliceerd.
</p>

```mermaid
classDiagram
    Song "*" -- "1" User : submitted by
    Translation "*" -- "1..*" User : translated by
    Comment "*" -- "1" User : added
    Comment "*" -- "1" Translation
    Comment "*" -- "1..*" Song

    %% Colors
    %%  Red
    style Translation fill:#f00
    %% Dark Blue
    style Song fill:#00f
    %% Purple
    style Comment fill:#f0f
    %% Orange
    style User fill:orange
```

### Artist

<p>
Een Artist kan alleen bestaan als er minstens 1 Song aan is gelinkt. <br>

Er kunnen op verschillende manier meerdere artiesten betrokken zijn bij dezelfde Song:
<ul>

<li>Als duo of groep; dit is gemodelleerd als 1 Artist instantie bijvoorbeeld <a href="https://lyricstranslate.com/en/suzan-freek-lyrics.html">Suzan & Freek</a></li>

<li>Een tijdelijke samenwerking waarbij er 1 hoofdartiest (Artist) is en 1 of meerdere instanties van een toegevoegde Artist, bijvoorbeeld <a href="https://lyricstranslate.com/en/hatik-perdant-magnifique-lyrics.html">Featuring artist Soprano</a><br>
</li>

<li>
Een Song is door meerdere artiesten worden gecovered (geen samenwerking maar wel toestemming), bijvoorbeeld <a href="https://lyricstranslate.com/en/Sylvie-Vartan-La-Maritza-lyrics.html">Also performed by: Camélia Jordana, Therion</a>
</li>

</ul>
</p>

```mermaid
classDiagram
    Song "1..*" -- "1..*" Artist : performed by
    Artist "*" -- "*" Song : featuring
    Song "1..*" -- "*" Artist : also performed by
    
    %% Colors
    %%  Red
    style Translation fill:#f00
    %% Dark Blue
    style Song fill:#00f
    %% Orange
    style Artist fill:orange   
```

## References
<ul>

<li>
<a href="https://mermaid.js.org/syntax/classDiagram.html">Mermaid Class diagrams</a>
</li>

<li>
<a href="https://gist.github.com/lqvers/05b06f344fa27b16235416b185f935d7">Quick Reference Mermaid diagrams</a>
</li>

<li>
<a href="https://www.uml-diagrams.org">Unified Modeling Language</a>
</li>

<li>
<a href="https://lyricstranslate.com">Lyrics Translations</a>
</li>

</ul>