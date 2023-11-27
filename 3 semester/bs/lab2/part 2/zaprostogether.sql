select assignment.assignment_id,
assignment.project_no,
assignment.worker_id,
worker.worker_name,
worker.position,
assignment.assignment_complexity from assignment
inner join worker on assignment.worker_id=worker.worker_id
where assignment_complexity between '10' and '20'
and worker.position = 'дизайнер'
order by assignment_complexity;
