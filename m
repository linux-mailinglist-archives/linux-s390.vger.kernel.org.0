Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328FF1B5B24
	for <lists+linux-s390@lfdr.de>; Thu, 23 Apr 2020 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDWMNx (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 23 Apr 2020 08:13:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60842 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726056AbgDWMNx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 08:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587644032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxBo8MqjJ9oqscRfRrEiSL/J610w813BUq0kwLAQ1v8=;
        b=GiL0/78SJ41YjJH1yoU54lZ3M3IgNFDTdxBvf/V61e2s6K/ReAhjhzNb1HGzR3ZezW6UTW
        xGDn0hUW0MhhhIoQNyx21KvQe89RzuzuQl0PhOpmiIXVVRj4YlHSdj7gzhQ5Ry9Wlk39Hr
        /pVe2n7rSgliWP1Lej2meFGycuo0NsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-XqIvzCN1NhSE5k_KjZXPKg-1; Thu, 23 Apr 2020 08:13:48 -0400
X-MC-Unique: XqIvzCN1NhSE5k_KjZXPKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E50DDDBB0;
        Thu, 23 Apr 2020 12:13:46 +0000 (UTC)
Received: from gondolin (ovpn-112-121.ams2.redhat.com [10.36.112.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A398A99DE;
        Thu, 23 Apr 2020 12:13:41 +0000 (UTC)
Date:   Thu, 23 Apr 2020 14:13:38 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, gor@linux.ibm.com, david@redhat.com,
        kbuild test robot <lkp@intel.com>,
        Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/protvirt: fix compilation issue
Message-ID: <20200423141338.15ee2edc.cohuck@redhat.com>
In-Reply-To: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
References: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 23 Apr 2020 14:01:14 +0200
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> The kernel fails to compile with CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> set but CONFIG_KVM unset.
> 
> This patch fixes the issue by making the needed variable always available.
> 
> Fixes: a0f60f8431999bf5 ("s390/protvirt: Add sysfs firmware interface for Ultravisor information")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Philipp Rudo <prudo@linux.ibm.com>
> Suggested-by: Philipp Rudo <prudo@linux.ibm.com>
> CC: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/boot/uv.c   | 2 --
>  arch/s390/kernel/uv.c | 3 ++-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

