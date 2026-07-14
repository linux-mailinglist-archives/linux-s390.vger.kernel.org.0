Return-Path: <linux-s390+bounces-22262-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 029bHNhHVmoA2wAAu9opvQ
	(envelope-from <linux-s390+bounces-22262-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:29:44 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC1755CFC
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:29:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=fHw8f9x8;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22262-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-22262-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ED81302EC23
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79A047DD76;
	Tue, 14 Jul 2026 14:29:37 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315447DD43
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:29:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039377; cv=none; b=mC5bovM4IdGjSs87Z07XE3FVBOgY1rCpqQ86hFJ6HbNDaPhQ8ECcWLGLE9bc7Jj6sYnEjB85HTigqCIFvLJ1tqPMiye831sjhvqqWlFQ63eEM9nZUTHaYzaJ1YH1LYAe6GX7Lh9+NBTiqaOEh7/vPtojTKBpqh8TJQ4c7hwQ4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039377; c=relaxed/simple;
	bh=HV4KXx3jCDo5tnyS2SR083CFGU4A98rHzoR25fN+NeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5ZXO3PfOM068/SW9XWXK02dGMW7rBzjaXr1uFWbDb0x/svvTkVo60W3PneGlMMovLD7kCM8LvDZvDw7G0GRwaoQhUmvG+iGMxI3NIcPXNEX7ZvtZYvWHI8fvhws0hXyNcMZmayyIxH07O1jPtwgcqFqk7eYguarx/25KJPSgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=fHw8f9x8; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so6076215e9.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039371; x=1784644171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nvrKYD5ArwJczv3P3+Ce5/GBU6hZFow7WIOmjK2Noeg=;
        b=fHw8f9x8RZOOPQd8Mm2kUYt4NWzctTLq5X2G/diUH3e100eOXh2xfWHZC3lMNsx2Xl
         FbHBTlfuqaVpv2pAX5O0iXv/ivF0qRh6D4/xBC1qfrSPafw2ykft9iy4nAitxLt9VFn2
         +VcUlbWF/2sg7v3RViTMXZMVlHDYt0BdhY7bFIYOrVcGv3JUF5qFn524qP9RJm92lZ2q
         oTeXvc80c5HvgK7A4q4tlRkcAcxcwuejvsEgKMP1HufBI3gnJvqcg0gKx2SggDVQ74FE
         m4Zux397TbjkfELO+lLOP91U2j2ysQ1gdg6q/QFv7IYn9N9ps20LShRH8GY5it15bbgR
         ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039371; x=1784644171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvrKYD5ArwJczv3P3+Ce5/GBU6hZFow7WIOmjK2Noeg=;
        b=PSHzn4teiFSxj7QHXIfJOClNqvIP6q5R+wugKjzAQ1hZuR4bCkDwWXk3J92+ozcA5d
         IpufFiKC2TylakYLIA+dBghEKrcPFCNsxL0Lq/E0FFj4/2dnmtkNta3HAJiC5wGtbdg4
         LxeAp/oc0m6L7Hf/wjcpMa4WhIKoUYs760nVNQeAbi6pH3yTMpHxS6o3ORYo+BVhFOwP
         YeawDVGrdxnWQUOixLUTSl4999HLqLkHjb0wcAhUs8mWJqD+J/vF8mJkAU8vbS5axi6Q
         KQlbA6PJ50AIGR5I1Vju72Zqj0pLU84x49V2Jc9OTzpvYtrcKxB5TrIZQMGy7h2BqJrX
         gNPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmHFasvf4FFHP34LxNTpUE9YsoGwVIfXePxyOpaBeYdQSB4WooKo7Siz0Rj6DZmWDx8cbkM5Z4QFb4@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZJv3BCjSbwXUZvC8lV+g+WuPMhMlzgwNk8BTPwSY8L7Y8W06
	+3gaik94TNnUOMMoEy9lVmN9xADPvBi243V0TazlyREKAhmhFl7/IiM9B2JX3qibGpA=
X-Gm-Gg: AfdE7ck3waRrt7vloiR2IBbZ2c7Z/gnIKkDuFGqqw2D8+fwuce8XYeFgdXawW9U2bGy
	SEKX56+fqRW1snRcTY0KqWIP2nEOIBTqPnGawEguxGs2TrR0oXfyEpFYF7cNxjkzP7ArNVjQ+XA
	OHwag1chGLpDDd5G/JMSu3VqvrPpGBv5lYBKFnW3VY4V3fcClEn3I13r0g4NdYuwjMsRqKmiWZj
	TXF6oL0hy6TmNGETcyjabM8BXaO8pFNfpo1YAFyuH/IVtoqMaLi1I6ZyathfCTu6fYYUqGcaZ5a
	2RVgwxlg7h86U6OUoSpbFqICRBa7pwiZwxBTrzIuB6M803ZonTiI6d0n9FukXN/ua9AIbwEFN8C
	qS3zq6PktLHQ1qbll/3hUjK7uKQg9srSYi9SbwZ5QHlnbRJwdaMrsQKr5GEeQWscYhwsBUxqmFl
	xwmTEY4I6eJcHIBXgsEvwBww==
X-Received: by 2002:a05:600c:8108:b0:495:39a9:f8bb with SMTP id 5b1f17b1804b1-49539a9f8cbmr17623035e9.27.1784039370894;
        Tue, 14 Jul 2026 07:29:30 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49506a1fbcesm81645145e9.0.2026.07.14.07.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:29:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 00/14] RDMA: Make device names unique per net namespace
Date: Tue, 14 Jul 2026 16:29:13 +0200
Message-ID: <20260714142927.1298897-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22262-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:yanjun.zhu@linux.dev,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51BC1755CFC

From: Jiri Pirko <jiri@nvidia.com>

RDMA device names are unique system-wide today:
__ib_device_get_by_name() checks a requested name against every
registered device regardless of the network namespace it lives in.
A device in one network namespace therefore cannot use a name already
taken in another, even in exclusive netns mode (netns_mode=0) where
the two are otherwise isolated. Net devices have no such restriction -
their names only need to be unique within a network namespace.

This series makes RDMA device names unique per network namespace,
matching net device semantics, and adapts the users that assumed
system-wide unique names.

Scoping reuses the existing rdma_dev_access_netns() predicate, so
behavior only changes in exclusive mode:
  - shared mode (default): names stay unique system-wide, no change;
  - exclusive mode: names only need to be unique within a namespace;
  - CONFIG_NET_NS=n: everything is init_net, names stay system-wide
    unique.

There are two users that cannot be made per-namespace and are
documented as known limitations instead of changed:
  - the rdma_cm configfs tree: configfs has no network namespace
    support, so it cannot represent two same-named devices;
  - SELinux ibendport labelling: endports are labelled by (device
    name, port) from a global policy; distinguishing same-named
    devices would need net namespace support in the SELinux policy
    language and tooling.

Tested with the new rxe_netns_names kselftest added in the last patch.

Jiri Pirko (14):
  RDMA/core: Pass the net namespace to the device name lookups
  RDMA/core: Handle device name conflicts when changing net namespace
  RDMA/core: Support renaming a device when changing its net namespace
  RDMA/nldev: Report net namespace move errors through extack
  RDMA/nldev: Allow setting the device name while changing net namespace
  net/smc: Look up the pnetid ib device within the net namespace
  RDMA/srp: Make the SRP sysfs class net namespace aware
  RDMA/cgroup: Disambiguate devices across net namespaces
  RDMA/cma: Document that CM configfs cannot be net namespace scoped
  RDMA/core: Document the SELinux ibendport net namespace limitation
  RDMA/core: Make device names unique per net namespace
  RDMA/rxe: Allow queue VMAs to outlive ucontexts
  RDMA/rxe: Implement disassociate_ucontext callback
  RDMA/selftests: Add rxe_netns_names test

 Documentation/ABI/testing/configfs-rdma_cm    |   4 +
 Documentation/admin-guide/cgroup-v1/rdma.rst  |   8 +
 Documentation/admin-guide/cgroup-v2.rst       |  15 +-
 drivers/infiniband/core/cgroup.c              |   1 +
 drivers/infiniband/core/cma_configfs.c        |   4 +
 drivers/infiniband/core/core_priv.h           |   3 +-
 drivers/infiniband/core/device.c              | 245 ++++++++++++---
 drivers/infiniband/core/nldev.c               |  26 +-
 drivers/infiniband/core/security.c            |   6 +
 drivers/infiniband/sw/rxe/rxe_mmap.c          |  35 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +
 drivers/infiniband/ulp/srp/ib_srp.c           |  16 +-
 include/linux/cgroup_rdma.h                   |   1 +
 include/uapi/rdma/rdma_netlink.h              |   5 +-
 kernel/cgroup/rdma.c                          |  71 ++++-
 net/smc/smc_pnet.c                            |  20 +-
 tools/testing/selftests/rdma/Makefile         |   3 +-
 tools/testing/selftests/rdma/config           |   2 +
 .../testing/selftests/rdma/rxe_netns_names.sh | 282 ++++++++++++++++++
 19 files changed, 653 insertions(+), 99 deletions(-)
 create mode 100755 tools/testing/selftests/rdma/rxe_netns_names.sh

-- 
2.54.0


