Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADC17A4F1
	for <lists+linux-s390@lfdr.de>; Thu,  5 Mar 2020 13:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgCEMLw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 5 Mar 2020 07:11:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:35278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgCEMLw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 5 Mar 2020 07:11:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F5D6B080;
        Thu,  5 Mar 2020 12:11:50 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm/vma: Introduce VM_ACCESS_FLAGS
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     hughd@google.com, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Nick Hu <nickhu@andestech.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Springer <rspringer@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1583391014-8170-1-git-send-email-anshuman.khandual@arm.com>
 <1583391014-8170-3-git-send-email-anshuman.khandual@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b3ab3943-7c3a-9c0a-17ba-bea254c5d5df@suse.cz>
Date:   Thu, 5 Mar 2020 13:11:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583391014-8170-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 3/5/20 7:50 AM, Anshuman Khandual wrote:
> There are many places where all basic VMA access flags (read, write, exec)
> are initialized or checked against as a group. One such example is during
> page fault. Existing vma_is_accessible() wrapper already creates the notion
> of VMA accessibility as a group access permissions. Hence lets just create
> VM_ACCESS_FLAGS (VM_READ|VM_WRITE|VM_EXEC) which will not only reduce code
> duplication but also extend the VMA accessibility concept in general.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Mark Salter <msalter@redhat.com>
> Cc: Nick Hu <nickhu@andestech.com>
> CC: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Springer <rspringer@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: devel@driverdev.osuosl.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
