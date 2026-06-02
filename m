Return-Path: <linux-s390+bounces-20331-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BjMK6EhHmr3hQkAu9opvQ
	(envelope-from <linux-s390+bounces-20331-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 02:19:45 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1FB626867
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 02:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAB08300B456
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 00:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235F29E0E5;
	Tue,  2 Jun 2026 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G42h9Bty"
X-Original-To: linux-s390@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5903299943
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359564; cv=none; b=AAHuM1g4xKO1ylL0Ew/bgCnYd89FQ63owhTu5pPVYNxh4jmKFoSveaSNjBIoANkAfO+tHvL/by3S9pDnn5kXVbkvEoGfVihn6FQjiJlbvMUeZKavoAR4Bk61aMSpYgtrnzthQXg9+ZL5AVD8dimAAgNfDMSs/1bY0wzVPaXV5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359564; c=relaxed/simple;
	bh=jWzhn8+4VsqMzQTJnaxarhu7ZfZOOm9BTYvI0g/2SUU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OT4+okcfmciKnXWJazy11S1So8QQqm/moa6s2WCvE6hW+3+BM0pSRiRMZj8yLAGNZY76cN+f2Vp1unsIjHRF5hz9WCNTgGfFxKByq0/Ckw/+SMcxDLb1CRSuyIQUN2giZjDogNUK78FM3T1/I2ERsOphAiZjbsSehzYax7ecnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G42h9Bty; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780359563; x=1811895563;
  h=date:from:to:cc:subject:message-id;
  bh=jWzhn8+4VsqMzQTJnaxarhu7ZfZOOm9BTYvI0g/2SUU=;
  b=G42h9Bty2Go3csclV7famOak+itMJh9n20kaoKUx02KrTwU9q4sOjp1M
   jAko3/09HZkypJgdoIFXpeZRo01i2BoQo3e3B8h6Fm8p6y0VjP9Pvihg8
   2DxgHIzuAUoesQxCq1tqvpl3F+6gm8zX7ZpcwgC34bFRXADMjRauN2udL
   pF1u8W3A13KtSWn1IHVYDzxzfXTaCpbnjvvxXaakmvE+0hRSaW9rkrqBb
   yejxsUrLolDXTw+OwJLB7FYyfZKrdVi1mhL/iC7/b13+z+jLtq+xTOnRv
   eEOHwfNG42K2/sirtDH0Q5LrFgLvpe8IfpXdstiMDrQ0XPHR71OjgQGGq
   Q==;
X-CSE-ConnectionGUID: 0M9wcOv5QA+6jK1Emfum4w==
X-CSE-MsgGUID: /S0do6jUTFCesGG4McxexQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81121928"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81121928"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:19:22 -0700
X-CSE-ConnectionGUID: lNIOHvjFRBCjChDI97htmA==
X-CSE-MsgGUID: gE2aTDI1TBCd37r+4kLZtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="274000048"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 01 Jun 2026 17:19:21 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUCqk-000000001gz-3C4Z;
	Tue, 02 Jun 2026 00:19:18 +0000
Date: Tue, 02 Jun 2026 02:19:05 +0200
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Steffen Eiden <seiden@linux.ibm.com>
Subject: [kvms390:sae 1/53] Warning: drivers/vfio/vfio_main.c:1547
 function parameter 'kvm_module' not described in 'vfio_file_set_kvm'
Message-ID: <202606020254.QBcahsev-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20331-lists,linux-s390=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url]
X-Rspamd-Queue-Id: 5A1FB626867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   f33dbafc8623f6c22ac90428a03f29019940b157
commit: 412a531e0fe32aad575353cda4214518278508d1 [1/53] VFIO: take reference to the KVM module
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260602/202606020254.QBcahsev-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260602/202606020254.QBcahsev-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606020254.QBcahsev-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/vfio/vfio_main.c:1547 function parameter 'kvm_module' not described in 'vfio_file_set_kvm'
>> Warning: drivers/vfio/vfio_main.c:1547 function parameter 'kvm_module' not described in 'vfio_file_set_kvm'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

