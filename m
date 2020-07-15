Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDA220780
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2020 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgGOIgX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Jul 2020 04:36:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37446 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729192AbgGOIgX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jul 2020 04:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594802181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNvetRDl2vilUXFbqgzafA8aBGGCQYNGMYLuLzvct9U=;
        b=fXC04ivGnYcpZ+AKbuKcDvS4nAvX4gV5vtY888hObzn8xhJnZbwYvpHohOputvC69t/h/A
        M14Z+RxcI/o88tWk354j6ayyWYnZBHyCeFQht04nLlBZYupGDgKCSs0wLnU5nkOele/Say
        uUhT/T1+afxEEZIBXbrGUVJOSYzZKIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-WsPBMdGtNm-5uARAGULH1w-1; Wed, 15 Jul 2020 04:36:19 -0400
X-MC-Unique: WsPBMdGtNm-5uARAGULH1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D42101083E94;
        Wed, 15 Jul 2020 08:36:17 +0000 (UTC)
Received: from [10.72.13.230] (ovpn-13-230.pek2.redhat.com [10.72.13.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C4D679CE4;
        Wed, 15 Jul 2020 08:36:11 +0000 (UTC)
Subject: Re: [PATCH v7 0/2] s390: virtio: let arch validate VIRTIO features
To:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        mst@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <73459586-3315-44cf-8d82-13a394bdf115@redhat.com>
Date:   Wed, 15 Jul 2020 16:36:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2020/7/15 下午4:31, Pierre Morel wrote:
> Hi all,
>
> The goal of the series is to give a chance to the architecture
> to validate VIRTIO device features.
>
> in this respin:
>
> 1) I kept removed the ack from Jason as I reworked the patch
>     @Jason, the nature and goal of the patch did not really changed
>             please can I get back your acked-by with these changes?


Yes.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>
> 2) Rewording for warning messages
>
> Regards,
> Pierre
>
> Pierre Morel (2):
>    virtio: let arch validate VIRTIO features
>    s390: virtio: PV needs VIRTIO I/O device protection
>
>   arch/s390/mm/init.c           | 28 ++++++++++++++++++++++++++++
>   drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>   include/linux/virtio_config.h |  1 +
>   3 files changed, 48 insertions(+)
>

