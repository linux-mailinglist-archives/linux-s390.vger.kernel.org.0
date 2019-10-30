Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0DBCE968B
	for <lists+linux-s390@lfdr.de>; Wed, 30 Oct 2019 07:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfJ3Gnd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 30 Oct 2019 02:43:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:12316 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfJ3Gnd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 02:43:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 23:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="gz'50?scan'50,208,50";a="374797801"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2019 23:43:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iPhhZ-0002WA-Rj; Wed, 30 Oct 2019 14:43:29 +0800
Date:   Wed, 30 Oct 2019 14:42:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] mm/sparse.c: mark populate_section_memmap as __meminit
Message-ID: <201910301400.4bEqOizH%lkp@intel.com>
References: <20191028165549.14478-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pjhaywqx4jtylufh"
Content-Disposition: inline
In-Reply-To: <20191028165549.14478-1-iii@linux.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


--pjhaywqx4jtylufh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ilya,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mmotm/master]

url:    https://github.com/0day-ci/linux/commits/Ilya-Leoshkevich/mm-sparse-c-mark-populate_section_memmap-as-__meminit/20191030-113800
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: sh-allnoconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.meminit.text+0x153c): Section mismatch in reference from the function __populate_section_memmap() to the function .init.text:memblock_alloc_try_nid()
   The function __meminit __populate_section_memmap() references
   a function __init memblock_alloc_try_nid().
   If memblock_alloc_try_nid is only used by __populate_section_memmap then
   annotate memblock_alloc_try_nid with a matching annotation.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--pjhaywqx4jtylufh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AMM62aS1VAAA

--pjhaywqx4jtylufh--
