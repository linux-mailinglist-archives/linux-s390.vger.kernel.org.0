Return-Path: <linux-s390+bounces-2265-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C15186D478
	for <lists+linux-s390@lfdr.de>; Thu, 29 Feb 2024 21:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF48B28461E
	for <lists+linux-s390@lfdr.de>; Thu, 29 Feb 2024 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA81504D1;
	Thu, 29 Feb 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN/zEQVY"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F911504CB;
	Thu, 29 Feb 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239072; cv=none; b=Y5LHFc5LaOn3QYMUGcbflx2UHBZ2Is07VcvY3kxS1D0R/BU8DMnXQeoG4KbktqXuZclo4uZUFP7KshWK7Ud73dMFR6uDiavI9GDxY9qk8aGQEI/6R2Lxv6phyJGhJCpZrmdAirLiBJI6bLf6S+ptNUIzAlX+UoGFWctZd/oy2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239072; c=relaxed/simple;
	bh=I+EymkwU1C2leoNdI8aU2Kcpdiz2ujgLAG0SkJyGVXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DngLvbI2fN5QJ8RACyhRQDU0/9FLJA2O0A6agzNW+4iELFOdGhTP6BLxOgZmV6J5nSNmGiujakf64KU5QY1iLZXpT9k/BsdnozmDRwOnnIgk/MoVZJzi5roCSI9pwrmEHXFWkJsHES2dO82uUOL0s6qBDMfpcbb/hdWMt2g5M3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN/zEQVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA491C43609;
	Thu, 29 Feb 2024 20:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239070;
	bh=I+EymkwU1C2leoNdI8aU2Kcpdiz2ujgLAG0SkJyGVXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dN/zEQVYbOZPa6oGopcYWjqaSLFBiMY6VUVJnZwa8iPj7QFrKeC6GyFm3vIl+A4XV
	 owQW+31Qj98Ap3avHxowuXHZQtug3y1lEO0kPpggT4lGQRRFyMRD7jkovU3Rikzhgz
	 S2x57O8Qd84ngQPglUhhxfRnfr7v/Sytut8gH3lrteD6z3RNWwM6YocQjapsFcPKEd
	 mEaIz8GsoyE0obClTZXG19nQYWdfqSV4eoTWcDjNFuFh2rsnfwQ3jyA2MeU4gYW95i
	 buMAJ5aPedFHEXHCSmUtkGnqKBnF+1fjISIGRJwWdtZwyyKTXIUHIKvGMBA0KFRA9G
	 bhtgHJzWpRJEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	twinkler@linux.ibm.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 10/24] net/iucv: fix the allocation size of iucv_path_table array
Date: Thu, 29 Feb 2024 15:36:50 -0500
Message-ID: <20240229203729.2860356-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit b4ea9b6a18ebf7f9f3a7a60f82e925186978cfcf ]

iucv_path_table is a dynamically allocated array of pointers to
struct iucv_path items. Yet, its size is calculated as if it was
an array of struct iucv_path items.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/iucv/iucv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 0ed6e34d6edd1..ce33adb65afb0 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -156,7 +156,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -544,7 +544,7 @@ static int iucv_enable(void)
 
 	cpus_read_lock();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
-- 
2.43.0


