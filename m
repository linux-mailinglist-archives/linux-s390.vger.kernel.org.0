Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710C2C1FE8
	for <lists+linux-s390@lfdr.de>; Mon, 30 Sep 2019 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfI3LW1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Sep 2019 07:22:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34791 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbfI3LW0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Sep 2019 07:22:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so7398942qke.1
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 04:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=5ieeuojKyDrT/avxGciERxdoQctNqsxjZK9jSrXbbU8=;
        b=o21ctz8b1I6tslPzChmXHPcBpcpFJyKpe0/lmmhyvLVcb7UwzGkfXGjhrDua9V3gh1
         FYP4yFVpy7iAz80D3V0cVBYf//2m41ycWVHzn4/FsCCzMVJBt0oJej1YYfshIJVwNO7X
         hNPppzmULBrqLtuOvsEo/s0JT6sMqB0EM2NFp59tZCq1zi/lGR3AajZuXQY0ZU1bJZTR
         CRDnaLF8wb4q70545d4woEd4SAO+5G5oMt3XbGRsjnBKvEmBFp8YdUanbzPTfdrccIFO
         CZufxIBlMZ83ix7mSgO5S0QS8O/pQokkHeD9LtQ6GrB3VZp+rekTzhHZvBXCYk+qSeiN
         kbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5ieeuojKyDrT/avxGciERxdoQctNqsxjZK9jSrXbbU8=;
        b=OuuvdqmbX9eyoWJNde5sF+Mw/PLrvsYkzk2z3SvHVj6DsgVZp9P1EDd8/2fngReU+S
         cV33j3OqS707rdaWRNkDkeEmsb4nhhwiIDRYKj2VseA5kzR+H0k7x0vxclrxHkHJIDYj
         9rCiYs9Ke2rp5x+nb7j5R4ptOB5/rdMAxm/PrA3iSp6FffmTPF08F8BdDpwsvvOp0Ef6
         O526GM5lLvABGqjFQ9m5h9GYddorrR3hhs3/XlIkeeIzYYkQcQE03MrkAgNszZpY74OX
         jjOm1CfywERMCu8y04Ief8wiJdBAcXZjGXujT42pnCD3Mn2hpnM+Nf4QZQhFxdMtRH+j
         HEwg==
X-Gm-Message-State: APjAAAVfCNpxDrNpFewsx3F0+e4pTn7oTf3rPZ27HUzvL4nXrlCh5Qjd
        ApLu/A9jZDhxu2Ttdnlp1zcSm+sV/mqcHg==
X-Google-Smtp-Source: APXvYqxoPO0skZH0OTWAmoBjaSWxJOhCffjiIqOU9RQez6VGdZLVY2y9xSrKx+sHcRNhjZHF+RjOZA==
X-Received: by 2002:a37:883:: with SMTP id 125mr18022177qki.478.1569842544489;
        Mon, 30 Sep 2019 04:22:24 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p199sm5506182qke.18.2019.09.30.04.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 04:22:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
Date:   Mon, 30 Sep 2019 07:22:23 -0400
Message-Id: <A5AEF8D5-C44F-406C-BCAA-79F32AA41219@lca.pw>
References: <20190930110434.5k47w7xfvkjcohkp@box>
Cc:     akpm@linux-foundation.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190930110434.5k47w7xfvkjcohkp@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: iPhone Mail (17A844)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> On Sep 30, 2019, at 7:04 AM, Kirill A. Shutemov <kirill@shutemov.name> wro=
te:
>=20
> Looks like Power also uses the hook. Have you check that this patch will
> not affect Power?

Yes, I did. Although I did only test radix memory which seems just return im=
mediately in arch_free_page(), I code-review the non-radix memory path and d=
id not find anything suspicious. However, if really needed, I could test has=
h memory config or adding powerpc developers to double-check.=
