<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="tei">

<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01//EN"/>

<xsl:template match="/">
<html lang="de">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Taxonomie - Austrian Baroque Corpus</title>
    <link rel="stylesheet" href="styles.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="container">
        <nav class="navigation">
            <div class="nav-links">
                <a href="index.html" class="nav-link">
                    <span class="nav-icon">🏠</span>
                    Startseite
                </a>
                <a href="persons_register.html" class="nav-link">
                    <span class="nav-icon">👥</span>
                    Register der Personen
                </a>
                <a href="places_register.html" class="nav-link">
                    <span class="nav-icon">🗺️</span>
                    Register der Orte
                </a>
                <a href="taxonomy.html" class="nav-link active">
                    <span class="nav-icon">📚</span>
                    Taxonomie
                </a>
                <a href="documents.html" class="nav-link">
                    <span class="nav-icon">📖</span>
                    Dokumente
                </a>
            </div>
        </nav>

        <header>
            <h1 class="header-title">Linguistische Taxonomie</h1>
            <div class="header-subtitle"><xsl:value-of select="//tei:title"/></div>
            <div class="credits">
                Herausgegeben von:
                <xsl:for-each select="//tei:respStmt[tei:resp='herausgegeben von']/tei:name/tei:name">
                    <xsl:value-of select="."/>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
            </div>
        </header>

        <div class="controls">
            <input type="text" class="search-box" placeholder="Kategorie suchen..." id="searchBox"/>
            <select class="sort-select" id="sortSelect">
                <option value="id">Nach ID sortieren</option>
                <option value="name">Nach Name sortieren</option>
                <option value="type">Nach Typ sortieren</option>
                <option value="frequency-desc">Häufigste Tags</option>
                <option value="frequency-asc">Seltenste Tags</option>
            </select>
            <select class="filter-select" id="categoryFilterSelect">
                <option value="all">Alle Kategorien</option>
                <option value="postags">Stuttgart-Tübingen-TagSet</option>
                <option value="cf1">Kontrahierte Formen I</option>
                <option value="cf2">Kontrahierte Formen II</option>
            </select>
        </div>

        <div class="stats">
            <div class="stat-item">
                <div class="stat-number" id="totalCategories">84</div>
                <div class="stat-label">Kategorien gesamt</div>
            </div>
            <div class="stat-item">
                <div class="stat-number" id="mainCategories">3</div>
                <div class="stat-label">Hauptkategorien</div>
            </div>
            <div class="stat-item">
                <div class="stat-number" id="subCategories">81</div>
                <div class="stat-label">Unterkategorien</div>
            </div>
            <div class="stat-item">
                <div class="stat-number" id="visibleCategories">84</div>
                <div class="stat-label">Sichtbare Kategorien</div>
            </div>
        </div>

        <!-- Tag Frequency Visualization -->
        <div class="chart-section">
            <h2 class="chart-title">Tag-Häufigkeiten Visualisierung</h2>
            <div class="chart-controls">
                <button class="chart-btn active" id="topTagsBtn">Top 20 Tags</button>
                <button class="chart-btn" id="allTagsBtn">Alle Tags</button>
                <button class="chart-btn" id="categoryBtn">Nach Kategorien</button>
            </div>
            <div class="chart-container">
                <canvas id="frequencyChart" width="800" height="400"></canvas>
            </div>
        </div>

        <div class="taxonomy-container">
            <xsl:for-each select="//tei:taxonomy">
                <div class="taxonomy-section" data-taxonomy-id="{@xml:id}">
                    <h2 class="taxonomy-title">
                        <xsl:choose>
                            <xsl:when test="@xml:id='postags'">Stuttgart-Tübingen-TagSet</xsl:when>
                            <xsl:otherwise><xsl:value-of select="@xml:id"/></xsl:otherwise>
                        </xsl:choose>
                    </h2>

                    <div class="person-grid taxonomy-grid" id="taxonomyGrid">
                        <xsl:for-each select=".//tei:category">
                            <xsl:sort select="@xml:id" order="ascending"/>
                            <div class="person-card taxonomy-card"
                                 data-name="{translate(@xml:id, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')}"
                                 data-description="{translate(tei:catDesc, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')}"
                                 data-parent="{../@xml:id}"
                                 data-level="{count(ancestor::tei:category)}"
                                 data-type="{ancestor::tei:taxonomy/@xml:id}">
                                <xsl:attribute name="data-frequency">
                                    <xsl:choose>
                                        <xsl:when test="@xml:id='NN'">29352</xsl:when>
                                        <xsl:when test="@xml:id='ART'">15088</xsl:when>
                                        <xsl:when test="@xml:id='ADV'">11152</xsl:when>
                                        <xsl:when test="@xml:id='APPR'">10108</xsl:when>
                                        <xsl:when test="@xml:id='ADJA'">9737</xsl:when>
                                        <xsl:when test="@xml:id='KON'">7012</xsl:when>
                                        <xsl:when test="@xml:id='PPER'">6581</xsl:when>
                                        <xsl:when test="@xml:id='VVFIN'">6135</xsl:when>
                                        <xsl:when test="@xml:id='FM'">5384</xsl:when>
                                        <xsl:when test="@xml:id='VAFIN'">5159</xsl:when>
                                        <xsl:when test="@xml:id='VVPP'">4531</xsl:when>
                                        <xsl:when test="@xml:id='KOUS'">3795</xsl:when>
                                        <xsl:when test="@xml:id='ADJD'">3399</xsl:when>
                                        <xsl:when test="@xml:id='VVINF'">3397</xsl:when>
                                        <xsl:when test="@xml:id='NE'">2835</xsl:when>
                                        <xsl:when test="@xml:id='PIAT'">2505</xsl:when>
                                        <xsl:when test="@xml:id='PIS'">2381</xsl:when>
                                        <xsl:when test="@xml:id='PPOSAT'">2206</xsl:when>
                                        <xsl:when test="@xml:id='CARD'">2201</xsl:when>
                                        <xsl:when test="@xml:id='VMFIN'">1779</xsl:when>
                                        <xsl:when test="@xml:id='PRELS'">1686</xsl:when>
                                        <xsl:when test="@xml:id='PTKNEG'">1623</xsl:when>
                                        <xsl:when test="@xml:id='PRF'">1127</xsl:when>
                                        <xsl:when test="@xml:id='PDS'">1123</xsl:when>
                                        <xsl:when test="@xml:id='PDAT'">1102</xsl:when>
                                        <xsl:when test="@xml:id='KOKOM'">1088</xsl:when>
                                        <xsl:when test="@xml:id='APPRART'">960</xsl:when>
                                        <xsl:when test="@xml:id='VVIMP'">750</xsl:when>
                                        <xsl:when test="@xml:id='PAV'">692</xsl:when>
                                        <xsl:when test="@xml:id='VAPP'">647</xsl:when>
                                        <xsl:when test="@xml:id='PTKVZ'">627</xsl:when>
                                        <xsl:when test="@xml:id='PWAV'">566</xsl:when>
                                        <xsl:when test="@xml:id='PTKZU'">558</xsl:when>
                                        <xsl:when test="@xml:id='ITJ'">498</xsl:when>
                                        <xsl:when test="@xml:id='VAINF'">497</xsl:when>
                                        <xsl:when test="@xml:id='PWS'">482</xsl:when>
                                        <xsl:when test="@xml:id='PWAT'">162</xsl:when>
                                        <xsl:when test="@xml:id='TRUNC'">124</xsl:when>
                                        <xsl:when test="@xml:id='VVFINPPER'">114</xsl:when>
                                        <xsl:when test="@xml:id='VMINF'">110</xsl:when>
                                        <xsl:when test="@xml:id='PRELAT'">110</xsl:when>
                                        <xsl:when test="@xml:id='PTKA'">108</xsl:when>
                                        <xsl:when test="@xml:id='VVIZU'">101</xsl:when>
                                        <xsl:when test="@xml:id='APPO'">65</xsl:when>
                                        <xsl:when test="@xml:id='APZR'">48</xsl:when>
                                        <xsl:when test="@xml:id='VAFINPPER'">45</xsl:when>
                                        <xsl:when test="@xml:id='XY'">42</xsl:when>
                                        <xsl:when test="@xml:id='PPOSS'">32</xsl:when>
                                        <xsl:when test="@xml:id='PTKANT'">30</xsl:when>
                                        <xsl:when test="@xml:id='KOUSPPER'">25</xsl:when>
                                        <xsl:when test="@xml:id='VAIMP'">20</xsl:when>
                                        <xsl:when test="@xml:id='PPERPPER'">19</xsl:when>
                                        <xsl:when test="@xml:id='VVIMPPPER'">17</xsl:when>
                                        <xsl:when test="@xml:id='VMPP'">14</xsl:when>
                                        <xsl:when test="@xml:id='PRFPPER'">13</xsl:when>
                                        <xsl:when test="@xml:id='PISPPER'">13</xsl:when>
                                        <xsl:when test="@xml:id='VMFINPPER'">11</xsl:when>
                                        <xsl:when test="@xml:id='KOUI'">10</xsl:when>
                                        <xsl:when test="@xml:id='VVIMPART'">2</xsl:when>
                                        <xsl:when test="@xml:id='PDSPPER'">1</xsl:when>
                                        <xsl:when test="@xml:id='ARTNN'">1</xsl:when>
                                        <xsl:when test="@xml:id='ADVART'">1</xsl:when>
                                        <xsl:otherwise>0</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>

                                <div class="taxonomy-header">
                                    <div class="person-name taxonomy-name">
                                        <xsl:value-of select="@xml:id"/>
                                        <xsl:if test="count(ancestor::tei:category) > 0">
                                            <span class="taxonomy-level-badge level-{count(ancestor::tei:category)}">
                                                Level <xsl:value-of select="count(ancestor::tei:category) + 1"/>
                                            </span>
                                        </xsl:if>
                                        <!-- Tag usage count -->
                                        <span class="tag-count-badge">
                                            <xsl:choose>
                                                <xsl:when test="@xml:id='NN'">29,352</xsl:when>
                                                <xsl:when test="@xml:id='ART'">15,088</xsl:when>
                                                <xsl:when test="@xml:id='ADV'">11,152</xsl:when>
                                                <xsl:when test="@xml:id='APPR'">10,108</xsl:when>
                                                <xsl:when test="@xml:id='ADJA'">9,737</xsl:when>
                                                <xsl:when test="@xml:id='KON'">7,012</xsl:when>
                                                <xsl:when test="@xml:id='PPER'">6,581</xsl:when>
                                                <xsl:when test="@xml:id='VVFIN'">6,135</xsl:when>
                                                <xsl:when test="@xml:id='FM'">5,384</xsl:when>
                                                <xsl:when test="@xml:id='VAFIN'">5,159</xsl:when>
                                                <xsl:when test="@xml:id='VVPP'">4,531</xsl:when>
                                                <xsl:when test="@xml:id='KOUS'">3,795</xsl:when>
                                                <xsl:when test="@xml:id='ADJD'">3,399</xsl:when>
                                                <xsl:when test="@xml:id='VVINF'">3,397</xsl:when>
                                                <xsl:when test="@xml:id='NE'">2,835</xsl:when>
                                                <xsl:when test="@xml:id='PIAT'">2,505</xsl:when>
                                                <xsl:when test="@xml:id='PIS'">2,381</xsl:when>
                                                <xsl:when test="@xml:id='PPOSAT'">2,206</xsl:when>
                                                <xsl:when test="@xml:id='CARD'">2,201</xsl:when>
                                                <xsl:when test="@xml:id='VMFIN'">1,779</xsl:when>
                                                <xsl:when test="@xml:id='PRELS'">1,686</xsl:when>
                                                <xsl:when test="@xml:id='PTKNEG'">1,623</xsl:when>
                                                <xsl:when test="@xml:id='PRF'">1,127</xsl:when>
                                                <xsl:when test="@xml:id='PDS'">1,123</xsl:when>
                                                <xsl:when test="@xml:id='PDAT'">1,102</xsl:when>
                                                <xsl:when test="@xml:id='KOKOM'">1,088</xsl:when>
                                                <xsl:when test="@xml:id='APPRART'">960</xsl:when>
                                                <xsl:when test="@xml:id='VVIMP'">750</xsl:when>
                                                <xsl:when test="@xml:id='PAV'">692</xsl:when>
                                                <xsl:when test="@xml:id='VAPP'">647</xsl:when>
                                                <xsl:when test="@xml:id='PTKVZ'">627</xsl:when>
                                                <xsl:when test="@xml:id='PWAV'">566</xsl:when>
                                                <xsl:when test="@xml:id='PTKZU'">558</xsl:when>
                                                <xsl:when test="@xml:id='ITJ'">498</xsl:when>
                                                <xsl:when test="@xml:id='VAINF'">497</xsl:when>
                                                <xsl:when test="@xml:id='PWS'">482</xsl:when>
                                                <xsl:when test="@xml:id='PWAT'">162</xsl:when>
                                                <xsl:when test="@xml:id='TRUNC'">124</xsl:when>
                                                <xsl:when test="@xml:id='VVFINPPER'">114</xsl:when>
                                                <xsl:when test="@xml:id='VMINF'">110</xsl:when>
                                                <xsl:when test="@xml:id='PRELAT'">110</xsl:when>
                                                <xsl:when test="@xml:id='PTKA'">108</xsl:when>
                                                <xsl:when test="@xml:id='VVIZU'">101</xsl:when>
                                                <xsl:when test="@xml:id='APPO'">65</xsl:when>
                                                <xsl:when test="@xml:id='APZR'">48</xsl:when>
                                                <xsl:when test="@xml:id='VAFINPPER'">45</xsl:when>
                                                <xsl:when test="@xml:id='XY'">42</xsl:when>
                                                <xsl:when test="@xml:id='PPOSS'">32</xsl:when>
                                                <xsl:when test="@xml:id='PTKANT'">30</xsl:when>
                                                <xsl:when test="@xml:id='KOUSPPER'">25</xsl:when>
                                                <xsl:when test="@xml:id='VAIMP'">20</xsl:when>
                                                <xsl:when test="@xml:id='PPERPPER'">19</xsl:when>
                                                <xsl:when test="@xml:id='VVIMPPPER'">17</xsl:when>
                                                <xsl:when test="@xml:id='VMPP'">14</xsl:when>
                                                <xsl:when test="@xml:id='PRFPPER'">13</xsl:when>
                                                <xsl:when test="@xml:id='PISPPER'">13</xsl:when>
                                                <xsl:when test="@xml:id='VMFINPPER'">11</xsl:when>
                                                <xsl:when test="@xml:id='KOUI'">10</xsl:when>
                                                <xsl:when test="@xml:id='VVIMPART'">2</xsl:when>
                                                <xsl:when test="@xml:id='PDSPPER'">1</xsl:when>
                                                <xsl:when test="@xml:id='ARTNN'">1</xsl:when>
                                                <xsl:when test="@xml:id='ADVART'">1</xsl:when>
                                                <xsl:otherwise>0</xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                    </div>

                                    <xsl:if test="ancestor::tei:taxonomy/@xml:id">
                                        <span class="taxonomy-type-badge">
                                            <xsl:choose>
                                                <xsl:when test="ancestor::tei:taxonomy/@xml:id='postags'">POS-Tag</xsl:when>
                                                <xsl:when test="ancestor::tei:taxonomy/@xml:id='cf1'">Kontraktion I</xsl:when>
                                                <xsl:when test="ancestor::tei:taxonomy/@xml:id='cf2'">Kontraktion II</xsl:when>
                                                <xsl:otherwise><xsl:value-of select="ancestor::tei:taxonomy/@xml:id"/></xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                    </xsl:if>
                                </div>

                                <div class="taxonomy-description">
                                    <xsl:value-of select="tei:catDesc"/>
                                </div>

                                <xsl:if test="tei:category">
                                    <div class="subcategories">
                                        <div class="subcategories-label">
                                            Unterkategorien (<xsl:value-of select="count(tei:category)"/>):
                                        </div>
                                        <div class="subcategories-list">
                                            <xsl:for-each select="tei:category">
                                                <span class="subcategory-tag">
                                                    <xsl:value-of select="@xml:id"/>
                                                </span>
                                            </xsl:for-each>
                                        </div>
                                    </div>
                                </xsl:if>

                                <xsl:if test="../@xml:id and ../@xml:id != ancestor::tei:taxonomy/@xml:id">
                                    <div class="parent-info">
                                        <span class="parent-label">Übergeordnet:</span>
                                        <span class="parent-name"><xsl:value-of select="../@xml:id"/></span>
                                    </div>
                                </xsl:if>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
            </xsl:for-each>
        </div>

        <div class="no-results hidden" id="noResults">
            Keine Kategorien gefunden, die den Suchkriterien entsprechen.
        </div>
    </div>

    <script>
        const searchBox = document.getElementById('searchBox');
        const sortSelect = document.getElementById('sortSelect');
        const categoryFilterSelect = document.getElementById('categoryFilterSelect');
        const taxonomyGrids = document.querySelectorAll('.taxonomy-grid');
        const noResults = document.getElementById('noResults');
        const visibleCategoriesCount = document.getElementById('visibleCategories');

        let allCards = Array.from(document.querySelectorAll('.taxonomy-card'));

        function updateVisibleCount() {
            const visibleCards = allCards.filter(card =&gt; !card.classList.contains('hidden'));
            visibleCategoriesCount.textContent = visibleCards.length;

            const hasVisibleCards = visibleCards.length > 0;

            // Show/hide taxonomy sections based on visible cards
            taxonomyGrids.forEach(grid =&gt; {
                const sectionCards = Array.from(grid.querySelectorAll('.taxonomy-card'));
                const visibleSectionCards = sectionCards.filter(card =&gt; !card.classList.contains('hidden'));
                const section = grid.closest('.taxonomy-section');

                if (visibleSectionCards.length > 0) {
                    section.style.display = 'block';
                } else {
                    section.style.display = 'none';
                }
            });

            if (!hasVisibleCards) {
                noResults.classList.remove('hidden');
            } else {
                noResults.classList.add('hidden');
            }
        }

        function filterAndSort() {
            const searchTerm = searchBox.value.toLowerCase().trim();
            const selectedCategory = categoryFilterSelect.value;
            const sortBy = sortSelect.value;

            // Filter cards
            allCards.forEach(card =&gt; {
                const name = card.dataset.name;
                const description = card.dataset.description;
                const type = card.dataset.type;

                const matchesSearch = !searchTerm ||
                    name.includes(searchTerm) ||
                    description.includes(searchTerm);

                const matchesCategory = selectedCategory === 'all' ||
                    type === selectedCategory;

                if (matchesSearch &amp;&amp; matchesCategory) {
                    card.classList.remove('hidden');
                } else {
                    card.classList.add('hidden');
                }
            });

            // Sort visible cards within each grid
            taxonomyGrids.forEach(grid =&gt; {
                const gridCards = Array.from(grid.querySelectorAll('.taxonomy-card'));
                const visibleGridCards = gridCards.filter(card =&gt; !card.classList.contains('hidden'));

                visibleGridCards.sort((a, b) =&gt; {
                    switch(sortBy) {
                        case 'id':
                            return a.dataset.name.localeCompare(b.dataset.name);
                        case 'name':
                            return a.dataset.description.localeCompare(b.dataset.description);
                        case 'type':
                            const levelA = parseInt(a.dataset.level) || 0;
                            const levelB = parseInt(b.dataset.level) || 0;
                            return levelA - levelB;
                        case 'frequency-desc':
                            const freqA = parseInt(a.dataset.frequency) || 0;
                            const freqB = parseInt(b.dataset.frequency) || 0;
                            return freqB - freqA; // Descending order (highest first)
                        case 'frequency-asc':
                            const freqA2 = parseInt(a.dataset.frequency) || 0;
                            const freqB2 = parseInt(b.dataset.frequency) || 0;
                            return freqA2 - freqB2; // Ascending order (lowest first)
                        default:
                            return 0;
                    }
                });

                // Reorder in DOM
                visibleGridCards.forEach(card =&gt; {
                    grid.appendChild(card);
                });
            });

            updateVisibleCount();
        }

        searchBox.addEventListener('input', filterAndSort);
        sortSelect.addEventListener('change', filterAndSort);
        categoryFilterSelect.addEventListener('change', filterAndSort);

        // Initialize
        filterAndSort();

        // Chart functionality
        const tagData = {
            'NN': 29352, 'ART': 15088, 'ADV': 11152, 'APPR': 10108, 'ADJA': 9737,
            'KON': 7012, 'PPER': 6581, 'VVFIN': 6135, 'FM': 5384, 'VAFIN': 5159,
            'VVPP': 4531, 'KOUS': 3795, 'ADJD': 3399, 'VVINF': 3397, 'NE': 2835,
            'PIAT': 2505, 'PIS': 2381, 'PPOSAT': 2206, 'CARD': 2201, 'VMFIN': 1779,
            'PRELS': 1686, 'PTKNEG': 1623, 'PRF': 1127, 'PDS': 1123, 'PDAT': 1102,
            'KOKOM': 1088, 'APPRART': 960, 'VVIMP': 750, 'PAV': 692, 'VAPP': 647,
            'PTKVZ': 627, 'PWAV': 566, 'PTKZU': 558, 'ITJ': 498, 'VAINF': 497,
            'PWS': 482, 'PWAT': 162, 'TRUNC': 124, 'VVFINPPER': 114, 'VMINF': 110,
            'PRELAT': 110, 'PTKA': 108, 'VVIZU': 101, 'APPO': 65, 'APZR': 48,
            'VAFINPPER': 45, 'XY': 42, 'PPOSS': 32, 'PTKANT': 30, 'KOUSPPER': 25,
            'VAIMP': 20, 'PPERPPER': 19, 'VVIMPPPER': 17, 'VMPP': 14, 'PRFPPER': 13,
            'PISPPER': 13, 'VMFINPPER': 11, 'KOUI': 10, 'VVIMPART': 2, 'PDSPPER': 1,
            'ARTNN': 1, 'ADVART': 1
        };

        let chart;
        const ctx = document.getElementById('frequencyChart').getContext('2d');

        function createChart(data, title, type = 'bar') {
            if (chart) {
                chart.destroy();
            }

            const labels = Object.keys(data);
            const values = Object.values(data);

            chart = new Chart(ctx, {
                type: type,
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Häufigkeit',
                        data: values,
                        backgroundColor: [
                            '#3498db', '#e74c3c', '#2ecc71', '#f39c12', '#9b59b6',
                            '#1abc9c', '#34495e', '#e67e22', '#95a5a6', '#16a085',
                            '#27ae60', '#2980b9', '#8e44ad', '#f1c40f', '#d35400'
                        ].concat(Array(labels.length).fill('#bdc3c7')),
                        borderColor: '#34495e',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        title: {
                            display: true,
                            text: title,
                            font: { size: 16, weight: 'bold' }
                        },
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Anzahl Vorkommen'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'POS-Tags'
                            },
                            ticks: {
                                maxRotation: 45
                            }
                        }
                    }
                }
            });
        }

        function showTopTags() {
            const sortedData = Object.entries(tagData)
                .sort((a, b) =&gt; b[1] - a[1])
                .slice(0, 20)
                .reduce((obj, [key, val]) =&gt; ({ ...obj, [key]: val }), {});
            createChart(sortedData, 'Top 20 häufigste POS-Tags');
        }

        function showAllTags() {
            const sortedData = Object.entries(tagData)
                .sort((a, b) =&gt; b[1] - a[1])
                .reduce((obj, [key, val]) =&gt; ({ ...obj, [key]: val }), {});
            createChart(sortedData, 'Alle POS-Tags nach Häufigkeit');
        }

        function showByCategory() {
            const categories = {
                'Nomen &amp; Artikel': ['NN', 'ART', 'NE', 'APPRART'],
                'Adjektive &amp; Adverbien': ['ADJA', 'ADJD', 'ADV'],
                'Verben': ['VVFIN', 'VAFIN', 'VVPP', 'VVINF', 'VMFIN', 'VVIMP', 'VAPP', 'VAINF'],
                'Pronomen': ['PPER', 'PIAT', 'PIS', 'PPOSAT', 'PRELS', 'PRF', 'PDS', 'PDAT'],
                'Konjunktionen': ['KON', 'KOUS', 'KOKOM', 'KOUI'],
                'Partikeln': ['PTKNEG', 'PTKVZ', 'PTKZU', 'PTKA', 'PTKANT'],
                'Präpositionen': ['APPR', 'APPO', 'APZR'],
                'Sonstiges': ['FM', 'CARD', 'PAV', 'PWAV', 'PWS', 'PWAT', 'ITJ', 'TRUNC', 'XY']
            };

            const categoryData = {};
            Object.entries(categories).forEach(([category, tags]) =&gt; {
                categoryData[category] = tags.reduce((sum, tag) =&gt; sum + (tagData[tag] || 0), 0);
            });

            createChart(categoryData, 'POS-Tags gruppiert nach Kategorien');
        }

        // Chart button event listeners
        document.getElementById('topTagsBtn').addEventListener('click', function() {
            document.querySelectorAll('.chart-btn').forEach(btn =&gt; btn.classList.remove('active'));
            this.classList.add('active');
            showTopTags();
        });

        document.getElementById('allTagsBtn').addEventListener('click', function() {
            document.querySelectorAll('.chart-btn').forEach(btn =&gt; btn.classList.remove('active'));
            this.classList.add('active');
            showAllTags();
        });

        document.getElementById('categoryBtn').addEventListener('click', function() {
            document.querySelectorAll('.chart-btn').forEach(btn =&gt; btn.classList.remove('active'));
            this.classList.add('active');
            showByCategory();
        });

        // Initialize chart with top tags
        showTopTags();
    </script>
</body>
</html>
</xsl:template>

</xsl:stylesheet>