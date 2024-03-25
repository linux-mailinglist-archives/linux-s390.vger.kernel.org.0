Return-Path: <linux-s390+bounces-2721-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EC88A0F5
	for <lists+linux-s390@lfdr.de>; Mon, 25 Mar 2024 14:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B711C3821F
	for <lists+linux-s390@lfdr.de>; Mon, 25 Mar 2024 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9A14659B;
	Mon, 25 Mar 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCvUAqM+"
X-Original-To: linux-s390@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5415ECCC;
	Mon, 25 Mar 2024 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348860; cv=none; b=PFQ1l2KdkmU39PbFjzsEAlelshSWacjh6Cce4TXBYRbli2OgrSbvIKngkmgZxQ2Qlcpwe2uMt7SUvKgWuKogzsy0cVQ1TaDw8WEdOJV4Q5qsrsnomB6bYTezIY30bcOQSfWg/viIl4C8c57vIKoyDyUv4XOKFvPKmjAQqTgXPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348860; c=relaxed/simple;
	bh=bS1S2X2CJjfZI9Wdu/gKC/PtojbjfoojrJoco+YT8K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FONK/Qc9G2oRRUFRsK6T4xFLA0OJjRbzn6Tvha7tgxjWP+GqVXo70yhQxf7VFPsoShkolB+SEmDT4tGOntWGsv7bA0aYZOg3A9HeadTglGO/bTCCw30Ia535SNBV2WXYzH/DvSzxMv0kaPI0i1ssQ4kQNuFhOPONP/5lOyBO0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCvUAqM+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348858; x=1742884858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bS1S2X2CJjfZI9Wdu/gKC/PtojbjfoojrJoco+YT8K0=;
  b=iCvUAqM+P763FFkqvP9fbv69XTONy7MqqfFgwaGSej2T5t05KuRiZri/
   HGqhHtZ+8zYRtnnMf/OEQk7iHFCZWOhPSAlt0yyhH/u5ydovpU+lym2Ct
   BDZ0LWQXMWylXc2l3AAIUXhqhT1zSzACUpRzgxgNGKBnLDtAHGpIv38CH
   ZVlHp0T2Oj2N9tmaCWN/eYT9lsayUYIBkf6Zz9y0Lsq17KMp4OK2Y/LIi
   C+UNSAKpaDaXMTe3VizOlPvo5OTBF006bn9sd0eD8edmcoG9LOl7hi/Hz
   jzgYhRapenVRCnafneDk38xovJOaJ75Z/P7CtKy7ZejDv4CWQgHemnTMA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17065130"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17065130"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629577"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:40:52 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH V2 03/19] vdso: Add CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
Date: Mon, 25 Mar 2024 08:40:07 +0200
Message-Id: <20240325064023.2997-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325064023.2997-1-adrian.hunter@intel.com>
References: <20240325064023.2997-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT in preparation to add
multiplication overflow protection to the VDSO time getter functions.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 lib/vdso/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d883ac299508..c46c2300517c 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,4 +30,11 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
 
+config GENERIC_VDSO_OVERFLOW_PROTECT
+	bool
+	help
+	  Select to add multiplication overflow protection to the VDSO
+	  time getter functions for the price of an extra conditional
+	  in the hotpath.
+
 endif
-- 
2.34.1


