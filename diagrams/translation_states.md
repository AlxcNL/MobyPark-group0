<!-- Author: J.A.Boogaard@hr.nl -->

# State Diagrams

## Song

<p>
Een Lyric wordt vertegenwoordigd door een Song object. Toevoegen van een Song vindt plaats vanaf de webpagina van de (hoofd)artiest via <i>add new song</i>.
</p>

```mermaid
%%{init: {'theme':'dark'}}%%

stateDiagram-v2
    [*] --> Edit: add new song
    Edit --> Published : save
    Published --> Edit: edit

    %% Colors
    %%  Red
    style Published fill:#f00
    %% Purple
    style Edit fill:#f0f
```

## Translation

<p>
Een vertaling (Translation) wordt aangemaakt als toegvoeging (Add) aan een Song. Na deze <i>start state</i> kan de vertaling worden bewerkt (Edit), opgeslagen (Save as Unpublished) en gepubliceerd (Publish). Na Published volgt geen <i>end state</i> want een gepubliceerde vertaling kan worden aangepast (Edit) of worden teruggeplaatst naar Unpublished (Move to drafts). 
</p>

```mermaid
%%{init: {'theme':'dark'}}%%

stateDiagram-v2
    [*] --> Edit: add new translation
    Edit --> Unpublished: save
    Edit --> Published: publish
    Unpublished --> Edit: edit
    Unpublished --> Published: publish
    Published --> Edit: edit
    Published --> Unpublished: move to drafts

    %% Colors
    %%  Red
    style Published fill:#f00
    %% Dark Blue
    style Unpublished fill:#00f
    %% Purple
    style Edit fill:#f0f
```

--

<p>
Als de auteur van de vertaling dezelfde User is die ook de Song heeft gepubliceerd, kan tijdens het bewerken van de vertaling (Edit) ook de Song worden bewerkt.

```mermaid
%%{init: {'theme':'dark'}}%%

stateDiagram-v2
    [*] --> EditTranslation: add new translation
    EditTranslation --> Unpublished: save
    Unpublished --> PublishedTranslation: publish
    Unpublished --> EditTranslation: edit
    EditTranslation --> EditSong : edit song
    EditSong --> PublishedSong : save song
    PublishedSong --> EditTranslation: edit
   
    %% Colors
    %%  Red
    style PublishedSong fill:#f00
    style PublishedTranslation fill:#f00
    %% Dark Blue
    style Unpublished fill:#00f
    %% Purple
    style EditTranslation fill:#f0f
    %% Orange
    style EditSong fill:orange
```

## References

<ul>

<li>
<a href="https://mermaid.js.org/syntax/stateDiagram.html">Mermaid State diagrams</a>
</li>

<li>
<a href="https://www.uml-diagrams.org">Unified Modeling Language</a>
</li>

<li>
<a href="https://lyricstranslate.com">Lyrics Translations</a>
</li>

</ul>