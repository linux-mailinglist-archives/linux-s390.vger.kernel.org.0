Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0685C1C
	for <lists+linux-s390@lfdr.de>; Thu,  8 Aug 2019 09:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbfHHHwx (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Aug 2019 03:52:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbfHHHwx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 8 Aug 2019 03:52:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79E08C08EC07;
        Thu,  8 Aug 2019 07:52:53 +0000 (UTC)
Received: from gondolin (dhcp-192-181.str.redhat.com [10.33.192.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E74519C69;
        Thu,  8 Aug 2019 07:52:51 +0000 (UTC)
Date:   Thu, 8 Aug 2019 09:52:49 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/mm: Use refcount_t for refcount
Message-ID: <20190808095249.4fc40eb1.cohuck@redhat.com>
In-Reply-To: <20190808071826.6649-1-hslester96@gmail.com>
References: <20190808071826.6649-1-hslester96@gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 08 Aug 2019 07:52:53 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu,  8 Aug 2019 15:18:26 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Reference counters are preferred to use refcount_t instead of
> atomic_t.
> This is because the implementation of refcount_t can prevent
> overflows and detect possible use-after-free.
> So convert atomic_t ref counters to refcount_t.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  arch/s390/include/asm/gmap.h |  4 +++-
>  arch/s390/mm/gmap.c          | 10 +++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
