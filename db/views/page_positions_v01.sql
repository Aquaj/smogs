SELECT
  row_number() OVER () AS id,
  pages.id AS page_id,

  publication_positions.position AS publication_position,
  publication_positions.publication_id,

  arc_positions.position + publication_positions.position AS arc_position,
  arc_positions.arc_id,

  story_positions.position + arc_positions.position + publication_positions.position AS story_position,
  story_positions.story_id

FROM pages
  JOIN (
    SELECT
      pages.id AS page_id,
      pages.publication_order AS position,
      publications.id AS publication_id
    FROM pages
      JOIN publications
        ON pages.publication_id = publications.id
  ) AS publication_positions
  ON publication_positions.page_id = pages.id

  JOIN (
    SELECT
      pages.id AS page_id,
      rolling_counts.previous_page_count AS position,
      arcs.id AS arc_id
    FROM pages
      JOIN publications
        ON pages.publication_id = publications.id
      JOIN arcs
        ON publications.arc_id = arcs.id
      JOIN (
        SELECT
          publications.id AS publication_id,
          COUNT(previous_pages.id) AS previous_page_count
        FROM publications
          LEFT JOIN publications AS previous_publications
                 ON publications.arc_id = previous_publications.arc_id
                AND previous_publications.published_at < publications.published_at
          LEFT JOIN pages AS previous_pages
                 ON previous_pages.publication_id = previous_publications.id
        GROUP BY publications.id
      ) AS rolling_counts
        ON rolling_counts.publication_id = publications.id
  ) AS arc_positions
  ON arc_positions.page_id = publication_positions.page_id

  JOIN (
    SELECT
      pages.id AS page_id,
      COALESCE(rolling_counts.previous_page_count) AS position,
      stories.id AS story_id
    FROM pages
      JOIN publications
        ON pages.publication_id = publications.id
      JOIN arcs
        ON publications.arc_id = arcs.id
      JOIN stories
        ON arcs.story_id = stories.id
      LEFT JOIN (
        SELECT
          arcs.id AS arc_id,
          COUNT(previous_pages.id) AS previous_page_count
        FROM arcs
          LEFT JOIN arcs AS previous_arcs
                 ON arcs.story_id = previous_arcs.story_id
                AND previous_arcs.position < arcs.position
          LEFT JOIN publications AS previous_publications
                 ON previous_publications.arc_id = previous_arcs.id
          LEFT JOIN pages AS previous_pages
                 ON previous_pages.publication_id = previous_publications.id
        GROUP BY arcs.id
      ) AS rolling_counts
        ON rolling_counts.arc_id = arcs.id
  ) AS story_positions
  ON story_positions.page_id = arc_positions.page_id
