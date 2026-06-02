Return-Path: <linux-s390+bounces-20424-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R2XFOso3H2pWiwAAu9opvQ
	(envelope-from <linux-s390+bounces-20424-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 22:06:34 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481A4631A16
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 22:06:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=bZ1bgRVE;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20424-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20424-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612A130AE55D
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ABF2C326C;
	Tue,  2 Jun 2026 20:00:30 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816A282F1F
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 20:00:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430430; cv=none; b=FFPkpNxnyiq71ANUI7Q2vR0fXv7cVbbL8CRXQ4Ey4ev0YELUvIjIlEUeL5MAuOYAf4ACswN8f39ayTu0e1d0PQCU5S9bNw3eFR3tpV2AFAPsPFr/je3Luif13mqB7kor4ro6w/ZKG7cMDEw7/Zgd0CZvEzo2wpcmoSi5LGMwCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430430; c=relaxed/simple;
	bh=Qrj81oOvIzXzumeKFJ6k6+neRfSdt7yfV/FBVD3fH94=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rp0SVqx4nmgk5RAxXfLTohH7Sd+D59KltkkcidElfc1LBlkvP+yEBz4ts+THlHXiXW0eVWIZxA/kbrWE0XMYco2No8ZnY9U1kM+weVABPXHpHzyAgSkQ1hQ88cx6wzrr8b6iN/GvH++VKi+7jxn5Q8aIKBwCao9hOiE0CtQ7mhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZ1bgRVE; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780430427; x=1811966427;
  h=date:from:to:cc:subject:message-id;
  bh=Qrj81oOvIzXzumeKFJ6k6+neRfSdt7yfV/FBVD3fH94=;
  b=bZ1bgRVEDHmJnnLt3EDb0RXPUeechNDIB5mbRSUWXrnB6GB3njL+RNTX
   SOAic18lkDcF8HSHY6TKOGvyaDr0fffP3FBYKZfacBrNhlWanlmPjL7pc
   YViNrLc8OmVsK0dN3pJMXGPlo9de5qZ5gt8hBYciwBGH5DzZdTKdjnghF
   c0PjC1F9YJYHHy11qtK+50mAQN5ffKJW/M+IpUmoyRSEa2Tl61V5bNcLN
   dD31fPWwp2vFAD0GlvcdzO3wYZVGGRrgkBdVVhz0wFwe3BfpMT9P2P0Rh
   bIrPcSF763H9SwBqA/URc4KzrflDyVM1naQp4hje97fWfZrWwSQktxh/s
   w==;
X-CSE-ConnectionGUID: eSOvV9zeQDeN65UBEGLxzA==
X-CSE-MsgGUID: ZW3oGEYxTiKhYfG5idOo4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="83810268"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="83810268"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 13:00:26 -0700
X-CSE-ConnectionGUID: oafopE5wRayn/Y/6mU3gTA==
X-CSE-MsgGUID: l8AkLcf7R0qbMl6RPPRLgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="239839822"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 02 Jun 2026 13:00:23 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUVHh-00000000CTA-0vHt;
	Tue, 02 Jun 2026 20:00:21 +0000
Date: Wed, 03 Jun 2026 03:59:32 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>
Subject: [kvms390:sae 51/53] <instantiation>:1:36: error: too many
 positional arguments
Message-ID: <202606030347.0s0rKGnQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:linux-s390@vger.kernel.org,m:gra@linux.ibm.com,m:nrb@linux.ibm.com,m:nsg@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20424-lists,linux-s390=lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-s390@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 481A4631A16

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   f33dbafc8623f6c22ac90428a03f29019940b157
commit: e343c452c6cc6071a6d2eb29d5d2fbdbfda84e4c [51/53] KVM: s390: arm64: Implement sysreg handling
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260603/202606030347.0s0rKGnQ-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260603/202606030347.0s0rKGnQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606030347.0s0rKGnQ-lkp@intel.com/

All errors (new ones prefixed by >>):

     589 |                     ~(ID_AA64MMFR0_EL1_RES0 | ID_AA64MMFR0_EL1_ASIDBITS)),
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:474:16: note: expanded from macro 'ID_FILTERED'
     474 |                  .set_user = set_##name, \
         |                              ^~~~~~~~~~
   <scratch space>:177:1: note: expanded from here
     177 | set_id_aa64mmfr0_el1
         | ^~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:588:2: note: previous initialization is here
     588 |         ID_FILTERED(ID_AA64MMFR0_EL1, id_aa64mmfr0_el1,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     589 |                     ~(ID_AA64MMFR0_EL1_RES0 | ID_AA64MMFR0_EL1_ASIDBITS)),
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:473:4: note: expanded from macro 'ID_FILTERED'
     473 |                  ID_DESC(sysreg),        \
         |                  ^~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:442:45: note: expanded from macro 'ID_DESC'
     442 | #define ID_DESC(name) SYS_DESC(SYS_##name), ID_DESC_DEFAULT_CALLBACKS
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:15: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                      ^~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:602:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     602 |         ID_UNALLOCATED(7, 5),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:492:18: note: expanded from macro 'ID_UNALLOCATED'
     492 |                  .visibility = raz_visibility,    \
         |                                ^~~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:602:2: note: previous initialization is here
     602 |         ID_UNALLOCATED(7, 5),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:491:4: note: expanded from macro 'ID_UNALLOCATED'
     491 |                  ID_DESC_DEFAULT_CALLBACKS,       \
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:41: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                                                ^~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:603:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     603 |         ID_UNALLOCATED(7, 6),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:492:18: note: expanded from macro 'ID_UNALLOCATED'
     492 |                  .visibility = raz_visibility,    \
         |                                ^~~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:603:2: note: previous initialization is here
     603 |         ID_UNALLOCATED(7, 6),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:491:4: note: expanded from macro 'ID_UNALLOCATED'
     491 |                  ID_DESC_DEFAULT_CALLBACKS,       \
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:41: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                                                ^~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:604:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     604 |         ID_UNALLOCATED(7, 7),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:492:18: note: expanded from macro 'ID_UNALLOCATED'
     492 |                  .visibility = raz_visibility,    \
         |                                ^~~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:604:2: note: previous initialization is here
     604 |         ID_UNALLOCATED(7, 7),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:491:4: note: expanded from macro 'ID_UNALLOCATED'
     491 |                  ID_DESC_DEFAULT_CALLBACKS,       \
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:41: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                                                ^~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:633:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     633 |         ID_FILTERED(CTR_EL0, ctr_el0,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     634 |                     CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     635 |                             CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     636 |                             CTR_EL0_IminLine_MASK),
         |                             ~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:474:16: note: expanded from macro 'ID_FILTERED'
     474 |                  .set_user = set_##name, \
         |                              ^~~~~~~~~~
   <scratch space>:35:1: note: expanded from here
      35 | set_ctr_el0
         | ^~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:633:2: note: previous initialization is here
     633 |         ID_FILTERED(CTR_EL0, ctr_el0,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     634 |                     CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     635 |                             CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     636 |                             CTR_EL0_IminLine_MASK),
         |                             ~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:473:4: note: expanded from macro 'ID_FILTERED'
     473 |                  ID_DESC(sysreg),        \
         |                  ^~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:442:45: note: expanded from macro 'ID_DESC'
     442 | #define ID_DESC(name) SYS_DESC(SYS_##name), ID_DESC_DEFAULT_CALLBACKS
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:15: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                      ^~~~~~~~~~
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16255, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16255,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16104, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16104,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -32750, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-32750,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16112, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16112,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16128, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16128,0
         |                 ^
   <instantiation>:1:35: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -8574, 0,
         |                                   ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-8574,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15872, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15872,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16240, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16240,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16103, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16103,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -32628, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-32628,0
         |                 ^
   <instantiation>:1:35: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -8573, 0,
         |                                   ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-8573,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16256, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16256,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16118, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16118,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14716, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14716,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14848, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14848,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16127, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16127,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16117, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16117,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16119, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16119,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15736, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15736,0
         |                 ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   44 warnings and 20 errors generated.
--
     589 |                     ~(ID_AA64MMFR0_EL1_RES0 | ID_AA64MMFR0_EL1_ASIDBITS)),
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:474:16: note: expanded from macro 'ID_FILTERED'
     474 |                  .set_user = set_##name, \
         |                              ^~~~~~~~~~
   <scratch space>:177:1: note: expanded from here
     177 | set_id_aa64mmfr0_el1
         | ^~~~~~~~~~~~~~~~~~~~
   sys_regs.c:588:2: note: previous initialization is here
     588 |         ID_FILTERED(ID_AA64MMFR0_EL1, id_aa64mmfr0_el1,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     589 |                     ~(ID_AA64MMFR0_EL1_RES0 | ID_AA64MMFR0_EL1_ASIDBITS)),
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:473:4: note: expanded from macro 'ID_FILTERED'
     473 |                  ID_DESC(sysreg),        \
         |                  ^~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:442:45: note: expanded from macro 'ID_DESC'
     442 | #define ID_DESC(name) SYS_DESC(SYS_##name), ID_DESC_DEFAULT_CALLBACKS
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:15: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                      ^~~~~~~~~~
   sys_regs.c:602:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     602 |         ID_UNALLOCATED(7, 5),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:492:18: note: expanded from macro 'ID_UNALLOCATED'
     492 |                  .visibility = raz_visibility,    \
         |                                ^~~~~~~~~~~~~~
   sys_regs.c:602:2: note: previous initialization is here
     602 |         ID_UNALLOCATED(7, 5),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:491:4: note: expanded from macro 'ID_UNALLOCATED'
     491 |                  ID_DESC_DEFAULT_CALLBACKS,       \
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:41: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                                                ^~~~~~~~~~~~~
   sys_regs.c:603:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     603 |         ID_UNALLOCATED(7, 6),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:492:18: note: expanded from macro 'ID_UNALLOCATED'
     492 |                  .visibility = raz_visibility,    \
         |                                ^~~~~~~~~~~~~~
   sys_regs.c:603:2: note: previous initialization is here
     603 |         ID_UNALLOCATED(7, 6),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:491:4: note: expanded from macro 'ID_UNALLOCATED'
     491 |                  ID_DESC_DEFAULT_CALLBACKS,       \
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:41: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                                                ^~~~~~~~~~~~~
   sys_regs.c:604:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     604 |         ID_UNALLOCATED(7, 7),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:492:18: note: expanded from macro 'ID_UNALLOCATED'
     492 |                  .visibility = raz_visibility,    \
         |                                ^~~~~~~~~~~~~~
   sys_regs.c:604:2: note: previous initialization is here
     604 |         ID_UNALLOCATED(7, 7),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:491:4: note: expanded from macro 'ID_UNALLOCATED'
     491 |                  ID_DESC_DEFAULT_CALLBACKS,       \
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:41: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                                                ^~~~~~~~~~~~~
   sys_regs.c:633:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     633 |         ID_FILTERED(CTR_EL0, ctr_el0,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     634 |                     CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     635 |                             CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     636 |                             CTR_EL0_IminLine_MASK),
         |                             ~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:474:16: note: expanded from macro 'ID_FILTERED'
     474 |                  .set_user = set_##name, \
         |                              ^~~~~~~~~~
   <scratch space>:35:1: note: expanded from here
      35 | set_ctr_el0
         | ^~~~~~~~~~~
   sys_regs.c:633:2: note: previous initialization is here
     633 |         ID_FILTERED(CTR_EL0, ctr_el0,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     634 |                     CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     635 |                             CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     636 |                             CTR_EL0_IminLine_MASK),
         |                             ~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:473:4: note: expanded from macro 'ID_FILTERED'
     473 |                  ID_DESC(sysreg),        \
         |                  ^~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:442:45: note: expanded from macro 'ID_DESC'
     442 | #define ID_DESC(name) SYS_DESC(SYS_##name), ID_DESC_DEFAULT_CALLBACKS
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kvm/arm64/sys_regs.h:439:15: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     439 |          .set_user = set_id_reg, .visibility = id_visibility, \
         |                      ^~~~~~~~~~
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16255, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16255,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16104, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16104,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -32750, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-32750,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16112, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16112,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16128, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16128,0
         |                 ^
   <instantiation>:1:35: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -8574, 0,
         |                                   ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-8574,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15872, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15872,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16240, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16240,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16103, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16103,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -32628, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-32628,0
         |                 ^
   <instantiation>:1:35: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -8573, 0,
         |                                   ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-8573,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16256, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16256,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16118, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16118,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14716, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14716,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14848, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14848,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16127, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16127,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16117, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16117,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16119, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16119,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15736, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:73:3: note: while in macro instantiation
      73 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15736,0
         |                 ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   44 warnings and 20 errors generated.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

